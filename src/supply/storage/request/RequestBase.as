package supply.storage.request {
	import org.osflash.signals.Signal;
	import org.osflash.signals.ISignal;
	import supply.storage.request.Request;

	/**
	 * @author jamieowen
	 */
	public class RequestBase implements Request
	{
		private var _onStart:ISignal 	= new Signal(this);
		private var _onComplete:ISignal = new Signal(this);
		
		public function RequestBase()
		{
			
		}
		
		public function get onStart():ISignal
		{
			return _onStart;
		}
		
		public function get onComplete():ISignal
		{
			return _onComplete;
		}
		
		public function execute():void
		{
			
		}
		
		public function dispose():void
		{		
			_onStart.removeAll();
			_onComplete.removeAll();
		}
	}
}
