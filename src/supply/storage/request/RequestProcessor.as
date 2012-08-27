package supply.storage.request {
	import org.swiftsuspenders.Injector;
	/**
	 * @author jamieowen
	 */
	public class RequestProcessor
	{
		[Inject]
		public var injector:Injector;
		
		private var _requestQueue:Vector.<RequestQueueItem>;
		
		public function RequestProcessor()
		{
			_requestQueue = new Vector.<RequestQueueItem>();
		}
		
		public function add(request:Request, message:RequestMessage):void
		{
			_requestQueue.push( new RequestQueueItem(request, message) );
		}
		
		public function start():void
		{
			
		}
		
		public function executeNext():void
		{
			
		}
		
		public function get processing():Boolean
		{
			return false;
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


