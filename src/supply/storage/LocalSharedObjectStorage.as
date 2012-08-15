package supply.storage {
	import supply.api.IStorage;
	import supply.api.IModel;
	import supply.queries.QueryOptions;
	import supply.queries.Query;

	/**
	 * @author jamieowen
	 */
	public class LocalSharedObjectStorage implements IStorage
	{
		public function query(query : Query, options : QueryOptions) : * {
		}

		public function add(model : IModel) : void {
		}

		public function save(model : IModel) : void {
		}

		public function destroy(model : IModel) : void {
		}
	}
}
