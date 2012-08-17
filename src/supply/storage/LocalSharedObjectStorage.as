package supply.storage {
	import supply.api.IModelManager;
	import supply.api.ISerializer;
	import supply.api.IModel;
	import supply.api.IStorage;
	import supply.queries.Query;
	import supply.queries.QueryOptions;

	/**
	 * @author jamieowen
	 */
	public class LocalSharedObjectStorage implements IStorage
	{
		[Inject(name="Model")]
		public var model:Class;
		
		[Inject]
		public var serializer:ISerializer;
		
		[Inject] // the model manager for the specific model.
		public var modelManager:IModelManager;
		
		//[Inject]
		//public var querySetManager:IQuerySetManager;
		
		//[Inject]
		//public var instances:IInstanceManager;
		
		
		public function LocalSharedObjectStorage()
		{

		}
		
		public function query(query : Query, options : QueryOptions) : *
		{
			return null;
		}

		public function create(model : IModel) : void
		{
			// by this time a uuid should have been generated for
			// the model instance.
			
			// as this is using localstorage we don't need
			// to serialize - we just register the model class alias.
			
			// get the local storage items array for the key named class type.
			
			// append the model instance to the local storage items array.
			
			// done.
			
			// the question is here is - does the user make a query to access this newly
			// create data item?
			// as we need to ake sure all instances of an object are the same.
			// to make sure that we capture any changes to any reference to this model instance.
			 
			// this would be better practice.
			
		}

		public function update(model : IModel) : void
		{
			// if
		}

		public function destroy(model : IModel) : void
		{
			
		}
	}
}
