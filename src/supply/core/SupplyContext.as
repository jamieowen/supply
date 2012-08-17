package supply.core {
	import supply.serialization.ObjectSerializer;
	import supply.api.IModelManager;
	import org.osflash.signals.Signal;
	import supply.api.IModel;
	import supply.api.ISerializer;
	import supply.api.IStorage;
	import supply.errors.RegisterError;
	import supply.reflect.isIModelClass;
	import supply.serialization.JSONSerializer;
	import supply.storage.LocalSharedObjectStorage;

	import org.swiftsuspenders.Injector;

	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;
	
	
	
	/**
	 * @author jamieowen
	 */
	public class SupplyContext
	{
		private var __models:Dictionary;
		private var _contextInjector:Injector;
		
		private function get _models():Dictionary{
			if( __models == null ){
				__models = new Dictionary();
			}
			return __models;
		}
		
		/**
		 * @param id A unique id to use for this Supply instance if more than one are used in an app.
		 */
		public function SupplyContext()
		{
			_contextInjector 	= new Injector();
			
			_contextInjector.map(Injector).toValue(_contextInjector);
			
			_contextInjector.map(Class,"Signal").toValue(Signal);
			_contextInjector.map(Class,"ModelManager").toValue(ModelManager);
			_contextInjector.map(Class,"Storage").toValue(LocalSharedObjectStorage);
			_contextInjector.map(Class,"Serializer").toValue(ObjectSerializer);
		}
		
		public function register(...models):void
		{
			var c:Class;
			// validate
			for each( c in models ){
				if ( !isIModelClass(c) ) {
					throw new RegisterError( "Registered models must implement the '" + getQualifiedClassName(IModel) + "' interface. No models registered." );
				}
				if( isRegistered(c)){
					throw new RegisterError("The model '" + getQualifiedClassName(c) + "' has already been registered." ); 
				}
			}
			// register
			for each( c in models ){
				const modelData:ContextModelData = new ContextModelData(c);
				_contextInjector.injectInto(modelData);
				modelData.initialise();
				_models[c] = modelData;
			}
		}
		
		public function unregister(model:Class):void
		{
			if( isRegistered(model) ){
				delete _models[model];
			}else
				throw new RegisterError("The model '" + getQualifiedClassName(model) + "' is not registered." );			
		}
		
		public function unregisterAll():void
		{
			for( var cls:Object in __models ){
				( __models[cls] as ContextModelData ).dispose();
				delete _models[cls];
			}
			
			__models = new Dictionary();
		}
		
		public function isRegistered( model:Class ):Boolean
		{
			if( _models[model] )
				return true;
			else
				return false;
		}
		
		public function objects( model:Class ):IModelManager
		{
			if( isRegistered(model) ){
				return ( _models[model] as ContextModelData ).manager;
			}else
				throw new RegisterError("The model '" + getQualifiedClassName(model) + "' is not registered." );			
		}
		
		public function injector( model:Class = null ):Injector
		{
			if( isRegistered(model) ){
				return ( _models[model] as ContextModelData ).injector;
			}else
				throw new RegisterError("The model '" + getQualifiedClassName(model) + "' is not registered." );			
		}

		
		// TODO: Possibilty for create() 	- but any model instance type
		// TODO: Possibilty for update() 	- but any model instance type
		// TODO: Possibilty for destroy() 	- but any model instance type
	}
}