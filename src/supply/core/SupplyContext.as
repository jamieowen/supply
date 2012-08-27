package supply.core {
	import supply.api.IModelManager;
	import supply.errors.RegisterError;
	import supply.storage.LSOStorage;

	import org.osflash.signals.Signal;
	import org.swiftsuspenders.Injector;

	import flash.utils.getQualifiedClassName;


	/**
	 * @author jamieowen
	 */
	public class SupplyContext
	{
		private var _uniqueName:String;
		
		private var _contextInjector:Injector;
		private var _contextModelManager:ContextModelManager;
		
		public function get name():String
		{
			return _uniqueName;
		}
		
		/**
		 * @param uniqueName A unique id to use for this Supply instance if more than one are used in an app.
		 */
		public function SupplyContext(uniqueName:String ="Supply")
		{
			_uniqueName 			= uniqueName;
			_contextInjector 		= new Injector();
			
			_contextInjector.map(Injector).toValue(_contextInjector);
			_contextInjector.map(SupplyContext).toValue(this);
			// default classes to use for Signal, ModelManager, Storage.
			_contextInjector.map(Class,"Signal").toValue(Signal);
			_contextInjector.map(Class,"ModelManager").toValue(ModelManager);
			_contextInjector.map(Class,"Storage").toValue(LSOStorage);
			
			_contextModelManager 	= new ContextModelManager();
			_contextInjector.map(ContextModelManager).toValue(_contextModelManager);
			_contextInjector.injectInto(_contextModelManager);
		}
		
		public function register(...classes):void
		{
			_contextModelManager.register.apply(this,classes);
		}
		
		public function unregister(...classes):void
		{
			_contextModelManager.unregister.apply(this,classes);
		}
		
		public function unregisterAll():void
		{
			_contextModelManager.unregisterAll();
		}
		
		public function getDataForModel( model:Class ):ContextModelData
		{
			return _contextModelManager.getDataForModel(model);
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