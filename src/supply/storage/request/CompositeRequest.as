package supply.storage.request {
	import org.osflash.signals.Signal;
	import org.osflash.signals.ISignal;
	import supply.storage.request.RequestBase;

	/**
	 * <p>
	 * Handles a list of sub-requests to compose a number of requests in to a single request.
	 * The composite request introduces asynchronous <code>preExecute()</code> and <code>postExecute()</code> methods.
	 * This enables the request to make an initial request that may populate the sub-requests.
	 * After the <code>onPreExecuteComplete</code> signal is dispatched the sub requests will be executed by the CompositeRequest class.
	 * After all sub-requests are complete, the <code>postExecute()</code> method will be executed.
	 * Once the <code>onPostExecuteComplete</code> signal is dispatched the usual <code>onComplete</code> signal required
	 * by a non-composite request will be executed.
	 * 
	 * @author jamieowen
	 */
	public class CompositeRequest extends RequestBase
	{
		public var onPreExecuteComplete:ISignal 	= new Signal(CompositeRequest);
		public var onPostExecuteComplete:ISignal 	= new Signal(CompositeRequest);
		
		private var _subRequests:Vector.<Request>;
		
		public function CompositeRequest()
		{
			super();
			
			_subRequests = new Vector.<Request>();
		}
		
		public function addSubRequest( request:Request ):void
		{
			_subRequests.push( request );
		}
		
		override public function execute():void
		{
			onStart.dispatch(this);
			onPreExecuteComplete.add( _onPreExecuteComplete );
			preExecute();
		}
		
		private function _onPreExecuteComplete(request:CompositeRequest):void
		{
			onPreExecuteComplete.remove(_onPreExecuteComplete);
		}

		private function _onPostExecuteComplete(request:CompositeRequest):void
		{
			onComplete.dispatch(this);
		}
		
		/**
		 * 
		 */
		public function preExecute():void
		{
			onPreExecuteComplete.dispatch();
		}
		
		/**
		 * 
		 */
		public function postExecute():void
		{
			onPostExecuteComplete.dispatch();
		}
		

		
	}
}
