package supply.core {
	import avmplus.getQualifiedClassName;

	import supply.api.IModelManager;
	import supply.api.IStorage;
	import supply.core.reflect.ReflectedModel;

	import org.swiftsuspenders.Injector;

	
	/**
	 * Holds all information related to a single model, including the reflection information, the model manager,  the manager
	 * scoped injector, storage class.
	 */
	public class ContextModelData
	{
		[Inject(name="ModelManager")]
		public var defaultModelManagerClass:Class;
		
		[Inject(name="Storage")]
		public var defaultStorageClass:Class;
		
		[Inject]
		public var contextInjector:Injector;
		
		[Inject]
		public var reflectionManager:ReflectionManager;
		
		public var injector:Injector;
		
		public var model:Class;
		
		private var _manager:IModelManager;
		private var _reflect:ReflectedModel;
		
		public function get reflect():ReflectedModel
		{
			return _reflect;
		}
		
		public function get type():String
		{
			return getQualifiedClassName(model);
		}
		
		/**
		 * A unique name based on the model's type.
		 * 
		 * The 
		 */
		public function get name():String
		{
			var name:String = type;
			name = name.replace( ".", "_" );
			name = name.replace( "::", "__" ); 
			return name;
		}
		
		public function ContextModelData(model:Class)
		{
			this.model 				 = model;
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
				injector.map(ContextModelData ).toValue(this);
				
				_reflect = reflectionManager.reflect(model);
				injector.map(ReflectedModel).toValue(_reflect);
				
				// check these as they can be injected to customize each models
				// storage options.
				if( !injector.satisfies(IStorage) ){
					injector.map(IStorage).toSingleton(defaultStorageClass);
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
