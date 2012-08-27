package supply.storage {
	import supply.api.ISerializer;
	import supply.api.IModel;
	import supply.api.IModelManager;
	import supply.api.IStorage;
	import supply.core.ContextModelData;
	import supply.core.ContextModelManager;
	import supply.core.modelHasId;
	import supply.errors.StorageError;
	import supply.queries.Query;
	import supply.queries.QueryOptions;
	import supply.serialization.ObjectSerializer;
	import supply.storage.lso.LSOCreateRequest;
	import supply.storage.lso.LSODestroyRequest;
	import supply.storage.lso.LSOModelMessage;
	import supply.storage.lso.LSOQueryMessage;
	import supply.storage.lso.LSOQueryRequest;
	import supply.storage.lso.LSOUpdateRequest;
	import supply.storage.request.RequestProcessor;

	import org.swiftsuspenders.Injector;

	/**
	 * @author jamieowen
	 */
	public class LSOStorage implements IStorage
	{
		[Inject]
		public var modelInfo:ContextModelData;
		
		[Inject]
		public var modelManager:IModelManager;
		
		[Inject]
		public var contextModelManager:ContextModelManager;
		
		[Inject]
		public var injector:Injector;
		
		
		private var __serializer:ObjectSerializer;
		private var __requestProcessor:RequestProcessor;
		
		private function get _requestProcessor():RequestProcessor
		{
			if( __requestProcessor == null ){
				__requestProcessor 	= new RequestProcessor();
				__serializer		= new ObjectSerializer();
				
				injector.map(ISerializer).toValue( __serializer );
				
				injector.injectInto(__requestProcessor);
				injector.injectInto(__serializer);
			}
			return __requestProcessor;
		}
		
		public function LSOStorage()
		{
			
		}
		
		public function query(query : Query, options : QueryOptions) : *
		{
			_requestProcessor.add( new LSOQueryRequest(), new LSOQueryMessage(query,options) );
		}
		
		public function create(model : IModel) : void
		{
			if( !modelHasId(model) )
			{
				_requestProcessor.add( new LSOCreateRequest(), new LSOModelMessage(model) );
			}else
				throw new StorageError("The model already has an id. Use update() to make changes.");
		}

		public function update(model : IModel) : void
		{
			if( modelHasId(model) ){
				_requestProcessor.add( new LSOUpdateRequest(), new LSOModelMessage(model) );
			}else
				throw new StorageError("The model has no id. Use create() to add the model first before updating.");
		}

		public function destroy(model : IModel) : void
		{
			if( modelHasId(model) ){
				_requestProcessor.add( new LSODestroyRequest(), new LSOModelMessage(model) );
			}else
				throw new StorageError("The model has no id. Use create() to add the model first before destroying.");			
		}
	}
}
