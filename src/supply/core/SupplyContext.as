package supply.core {
	import supply.api.IModelManager;
	import supply.errors.RegisterError;
	import supply.serialization.ObjectSerializer;
	import supply.storage.LocalSharedObjectStorage;

	import org.osflash.signals.Signal;
	import org.swiftsuspenders.Injector;

	import flash.utils.getQualifiedClassName;


	/**
	 * @author jamieowen
	 */
	public class SupplyContext
	{
		private var _contextInjector:Injector;
		private var _contextModelManager:ContextModelManager;
		
		/**
		 * @param id A unique id to use for this Supply instance if more than one are used in an app.
		 */
		public function SupplyContext()
		{
			_contextInjector 		= new Injector();
			
			_contextInjector.map(Injector).toValue(_contextInjector);
			_contextInjector.map(SupplyContext).toValue(this);
			_contextInjector.map(Class,"Signal").toValue(Signal);
			_contextInjector.map(Class,"ModelManager").toValue(ModelManager);
			_contextInjector.map(Class,"Storage").toValue(LocalSharedObjectStorage);
			_contextInjector.map(Class,"Serializer").toValue(ObjectSerializer);
			
			_contextModelManager 	= new ContextModelManager();
			_contextInjector.map(ContextModelManager).toValue(_contextModelManager);
			_contextInjector.injectInto(_contextModelManager);
		}
		
		public function register(...classes):void
		{
			_contextModelManager.register.apply(this,classes);
		}
		
		public function unregister(model:Class):void
		{
			_contextModelManager.unregister(model);
		}
		
		public function unregisterAll():void
		{
			_contextModelManager.unregisterAll();
		}
		
		public function isRegistered( model:Class ):Boolean
		{
			return _contextModelManager.isRegistered(model);
		}
		
		public function objects( model:Class ):IModelManager
		{
			return _contextModelManager.manager(model);
		}
		
		public function injector( model:Class = null ):Injector
		{
			if( isRegistered(model) ){
				return _contextModelManager.getDataForModel(model).injector;
			}else
				throw new RegisterError("The model '" + getQualifiedClassName(model) + "' is not registered." );			
		}

		// TODO: Possibilty for create() 	- but any model instance type
		// TODO: Possibilty for update() 	- but any model instance type
		// TODO: Possibilty for destroy() 	- but any model instance type
	}
}