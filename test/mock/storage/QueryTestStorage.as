package mock.storage {
	import supply.api.IStorage;
	import supply.queries.QueryOptions;
	import supply.api.IModel;
	import supply.queries.Query;

	/**
	 * A mock storage object to pass the query results back to the Test Class.
	 * Used in the QueryTestSuite.
	 * 
	 * @author jamieowen
	 */
	public class QueryTestStorage implements IStorage
	{
		public var onQuery:Function;
		
		public function setModel( model:Class ):void
		{		
		}
		
		public function query(query : Query, options : QueryOptions) : *
		{
			if( onQuery != null ){
				onQuery( query, options );
			}
		}

		public function create(model : IModel) : void {
		}

		public function update(model : IModel) : void {
		}

		public function destroy(model : IModel) : void {
		}
	}
}
