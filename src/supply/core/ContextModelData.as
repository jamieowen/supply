package supply.core {
	import supply.api.IModelManager;
	import supply.api.ISerializer;
	import supply.api.IStorage;
	import supply.reflect.ReflectModel;

	import org.swiftsuspenders.Injector;
	
	
	internal class ContextModelData
	{
		[Inject(name="ModelManager")]
		public var defaultModelManagerClass:Class;
		
		[Inject(name="Storage")]
		public var defaultStorageClass:Class;
		
		[Inject(name="Serializer")]
		public var defaultSerializerClass:Class;
		
		[Inject]
		public var contextInjector:Injector;
		
		public var injector:Injector;
		
		private var _model:Class;
		private var _manager:IModelManager;
		
		public function ContextModelData(model:Class)
		{
			this._model 				 = model;
		}
		// call initialise after injections have been made.
		public function initialise():void
		{
			injector 				 	= new Injector();
			injector.parentInjector 	= contextInjector;
		}
		
		public function get manager():IModelManager
		{
			if( _manager == null ){
				// only init the model manager when first requested 
				// this usually is by a create(), query(), etc, call.
				// this allows any model level injection mappings to be setup
				// after calls to register() are made.
				
				// to inject custom model manager class - use the context injector 
				// and inject a mapping for - injector.map( Class, "ModelManager" )
				
				_manager = new defaultModelManagerClass();
				injector.map(IModelManager).toValue(_manager);
				
				injector.map(Injector).toValue(injector);
				injector.map(Class, "Model").toValue(_model);
				
				const reflect:ReflectModel = new ReflectModel(_model);
				injector.map(ReflectModel).toValue(reflect);
				
				// check these as they can be injected to customize each models
				// storage and serialization options.
				if( !injector.satisfies(IStorage) ){
					injector.map(IStorage).toSingleton(defaultStorageClass);
				}
				
				if( !injector.satisfies(ISerializer) ){
					injector.map(ISerializer).toSingleton(defaultSerializerClass);
				}
				
				injector.injectInto(_manager);
				
			}
			return _manager;
		}
		
		public function dispose():void
		{
			// TODO - implement and test proper dispose.
			trace( "-------- >>>> IMPLEMENT PROPER DISPOSE");
		}
	}
}
