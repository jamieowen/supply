package supply.storage.lso {
	import supply.queries.QueryOptions;
	import supply.queries.Query;
	import supply.storage.request.RequestMessage;

	/**
	 * @author jamieowen
	 */
	public class LSOQueryMessage implements RequestMessage
	{
		public var query:Query;
		public var options:QueryOptions;
		
		public function LSOQueryMessage(query:Query, options:QueryOptions)
		{
			this.query 		= query;
			this.options 	= options;
		}
	}
}
