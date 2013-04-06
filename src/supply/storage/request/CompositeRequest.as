package supply.storage.request {
	import avmplus.getQualifiedClassName;

	import org.osflash.signals.Signal;
	import org.swiftsuspenders.Injector;

	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.utils.getDefinitionByName;
	
	/**
	 * Manages a list of requests and executes them asynchronosly.
	 * 
	 * @author jamieowen
	 */
	public class CompositeRequest extends RequestBase
	{
		/** Dispatched each time a sub-request starts. **/
		public var onSubRequestStart:Signal 		= new Signal(Request);
		/** Dispatched each time a sub-request completes. **/
		public var onSubRequestComplete:Signal 		= new Signal(Request);
		/** Dispatched each time a sub-request timeouts. **/
		public var onSubRequestTimeout:Signal		= new Signal(Request);
		
		/** 
		 * Injector used to satisfy dependencies in requests. 
		 * The injector will be a model manager scoped injector.
		 */
		[Inject]
		public var injector:Injector; 
		
		private var _subRequestQueue:Vector.<RequestQueueItem>;
		private var _processing:Boolean;
		private var _currentSubRequest:RequestQueueItem;
		private var _timeout:uint;
		private var _autoExecute:Boolean;
		private var _timer:Timer;
		
		/**
		 * Creates a new CompositeRequest.
		 * 
		 * @param timeout The timeout to move on for each subrequest.
		 * @param autoExecute Auto-execute the sub-request when adding. 
		 */
		public function CompositeRequest(timeout:uint = 10000, autoExecute:Boolean = false)
		{
			_timeout 			= timeout;
			_autoExecute		= autoExecute;
			_processing 		= false;
			_subRequestQueue 	= new Vector.<RequestQueueItem>();
			_timer 				= new Timer(_timeout,1);
		}
		
		/**
		 * Adds a request and request message to the queue.
		 * If the <code>autoExecute</code> option is set the request will be executed
		 * immediately, or in line with any requests currently being processed.
		 */
		public function add(request:Request, message:RequestMessage):void
		{
			_subRequestQueue.push( new RequestQueueItem(request, message) );
			if( !processing && _autoExecute )
				executeSubRequests();
		}
		
		/**
		 *
		 */
		override public function execute():void
		{
			addSubRequests();
			executeSubRequests();
		}
		
		/**
		 * Allows the sub class to add sub-requests before executing.
		 */
		protected function addSubRequests():void
		{
			
		}
		
		/**
		 * Starts executing the sub-requests in the queue.
		 */
		protected function executeSubRequests():void
		{
			if( _processing ) return;
			_processing = true;
			onStart.dispatch(this);
			processNext();
		}
		
		/**
		 * Processes the next sub request and injects message dependencies
		 * into the request.
		 */
		private function processNext():void
		{
			if( _subRequestQueue.length > 0 ){
				_currentSubRequest = _subRequestQueue.splice(0,1)[0] as RequestQueueItem;
				_currentSubRequest.request.onStart.add(_onRequestStart);
				_currentSubRequest.request.onComplete.add(_onRequestComplete);
				_timer.addEventListener( TimerEvent.TIMER_COMPLETE, _onTimerComplete );
				_timer.start();
				
				// satisfy dependencies
				var messageClass:Class = getDefinitionByName( getQualifiedClassName(_currentSubRequest.message) ) as Class;
				injector.map(messageClass).toValue( _currentSubRequest.message );
				injector.injectInto(_currentSubRequest.request);
				
				_currentSubRequest.request.execute();
				
			}else{
				_processing = false;
				onComplete.dispatch(this);
			}
		}
		
		private function _onRequestStart(request:Request):void
		{
			onSubRequestStart.dispatch(request);
		}

		private function _onRequestComplete(request:Request):void
		{
			clearCurrentListeners();
			onSubRequestComplete.dispatch(request);
			clearCurrentQueueItem();
			processNext();
		}
		
		private function clearCurrentListeners():void
		{
			_timer.removeEventListener( TimerEvent.TIMER_COMPLETE, _onTimerComplete );
			if( _timer.running ) 
				_timer.stop();
				
			if( _currentSubRequest == null ) return;
						
			_currentSubRequest.request.onStart.remove(_onRequestStart);
			_currentSubRequest.request.onComplete.remove( _onRequestComplete );			
		}
		
		private function clearCurrentQueueItem():void
		{
			if( _currentSubRequest == null ) return;
			
			var messageClass:Class = getDefinitionByName( getQualifiedClassName(_currentSubRequest.message) ) as Class;
			injector.unmap(messageClass);
			_currentSubRequest.message = null;
			_currentSubRequest.request = null;
			_currentSubRequest = null;
		}
		
		private function _onTimerComplete(event:TimerEvent):void
		{
			clearCurrentListeners();
			onSubRequestTimeout.dispatch(_currentSubRequest.request);
			clearCurrentQueueItem();
			processNext();
		}
		
		override public function dispose():void
		{
			super.dispose();
			
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


