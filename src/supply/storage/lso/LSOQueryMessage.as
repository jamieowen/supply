package supply.storage.lso {
	import supply.queries.QuerySet;
	import supply.storage.request.RequestMessage;

	/**
	 * @author jamieowen
	 */
	public class LSOQueryMessage implements RequestMessage
	{
		public var querySet:QuerySet;
		
		public function LSOQueryMessage(querySet:QuerySet)
		{
			this.querySet = querySet;
		}
	}
}
