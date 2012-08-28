package supply.storage.request {
	import avmplus.getQualifiedClassName;

	import org.osflash.signals.Signal;
	import org.swiftsuspenders.Injector;

	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.utils.getDefinitionByName;
	/**
	 * @author jamieowen
	 */
	public class RequestProcessor
	{
		public var onRequestStart:Signal 	= new Signal(Request);
		public var onRequestComplete:Signal = new Signal(Request);
		public var onRequestTimeout:Signal	= new Signal(Request);
		
		public var onStart:Signal 			= new Signal(RequestProcessor);
		public var onComplete:Signal		= new Signal(RequestProcessor);
		 
		[Inject]
		public var injector:Injector;
		
		private var _requestQueue:Vector.<RequestQueueItem>;
		private var _processing:Boolean;
		private var _current:RequestQueueItem;
		private var _timeout:uint;
		private var _autoProcess:Boolean;
		private var _timer:Timer;
		
		public function RequestProcessor(timeout:uint = 10000, autoProcess:Boolean = true )
		{
			_timeout 		= timeout;
			_autoProcess	= autoProcess;
			_processing 	= false;
			_requestQueue 	= new Vector.<RequestQueueItem>();
			_timer 			= new Timer(_timeout,1);
		}
		
		public function add(request:Request, message:RequestMessage):void
		{
			_requestQueue.push( new RequestQueueItem(request, message) );
			if( !processing && _autoProcess )
				start();
		}
		
		public function start():void
		{
			if( _processing ) return;
			_processing = true;
			onStart.dispatch(this);
			processNext();
		}
		
		private function processNext():void
		{
			if( _requestQueue.length > 0 ){
				_current = _requestQueue.splice(0,1)[0] as RequestQueueItem;
				_current.request.onStart.add(_onRequestStart);
				_current.request.onComplete.add(_onRequestComplete);
				_timer.addEventListener( TimerEvent.TIMER_COMPLETE, _onTimerComplete );
				_timer.start();
				
				// satisfy dependencies
				var messageClass:Class = getDefinitionByName( getQualifiedClassName(_current.message) ) as Class;
				injector.map(messageClass).toValue( _current.message );
				injector.injectInto(_current.request);
				
				_current.request.execute();
				
			}else{
				_processing = false;
				onComplete.dispatch(this);
			}
		}
		
		private function _onRequestStart(request:Request):void
		{
			onRequestStart.dispatch(request);
		}

		private function _onRequestComplete(request:Request):void
		{
			clearCurrentListeners();
			onRequestComplete.dispatch(request);
			clearCurrentQueueItem();
			processNext();
		}
		
		private function clearCurrentListeners():void
		{
			_timer.removeEventListener( TimerEvent.TIMER_COMPLETE, _onTimerComplete );
			if( _timer.running ) 
				_timer.stop();
				
			if( _current == null ) return;
						
			_current.request.onStart.remove(_onRequestStart);
			_current.request.onComplete.remove( _onRequestComplete );			
		}
		
		private function clearCurrentQueueItem():void
		{
			if( _current == null ) return;
			
			var messageClass:Class = getDefinitionByName( getQualifiedClassName(_current.message) ) as Class;
			injector.unmap(messageClass);
			_current.message = null;
			_current.request = null;
			_current = null;
		}
		
		private function _onTimerComplete(event:TimerEvent):void
		{
			clearCurrentListeners();
			onRequestTimeout.dispatch(_current.request);
			clearCurrentQueueItem();
			processNext();
		}
		
		public function dispose():void
		{
			if( _processing ){
				clearCurrentListeners();
				clearCurrentQueueItem();
				_timer = null;
			}
		}
		
		public function get processing():Boolean
		{
			return _processing;
		}
	}
}
import supply.storage.request.Request;
import supply.storage.request.RequestMessage;

internal class RequestQueueItem
{
	public var request:Request;
	public var message:RequestMessage;

	public function RequestQueueItem(request:Request, message:RequestMessage)
	{
		this.request = request;
		this.message = message;
	}
}


