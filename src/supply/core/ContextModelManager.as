package supply.core {
	import org.swiftsuspenders.Injector;
	import supply.api.IModel;
	import supply.core.reflect.isIModelClass;
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;
	import supply.errors.RegisterError;
	import supply.api.IModelManager;

	/**
	 * Manages all Models in a Context.
	 * 
	 * @author jamieowen
	 */
	public class ContextModelManager
	{
		[Inject]
		public var contextInjector:Injector;
		
		private var __models:Dictionary;
		
		/**
		 * An internal 
		 */
		private function get _models():Dictionary
		{
			if( __models == null ){
				__models = new Dictionary();
			}
			return __models;
		}
		
		/**
		 * Returns a Dictionary mapping Model class to 
		 * a ContextModelData instance.
		 */
		public function get models():Dictionary
		{
			return _models;	
		}
		
		/**
		 * Gets the specific ContextModelData for a Model class.
		 */
		public function getDataForModel( model:Class ):ContextModelData
		{
			if( isRegistered(model) ){
				return _models[model];
			}else
				throw new RegisterError("The model '" + getQualifiedClassName(model) + "' is not registered." );			
		}
		
		/**
		 * Returns a ContextModelData instance for a flash type string. ( e.g. 'app.models::MyModel' )
		 * If no Model exists for that string, null is returned.
		 */
		public function getDataForType( type:String ):ContextModelData
		{
			var data:ContextModelData = null;
			for each( var d:Object in models ){
				data = d as ContextModelData;
				if( data.type == type )
					return data;
			}
			return null;
		}
		
		/**
		 * Creates a ContextModelManager.
		 */
		public function ContextModelManager()
		{
			
		}
		
		/**
		 * Retrieves the IModelManager instance for a spefic Model class.
		 */
		public function manager( model:Class ):IModelManager
		{
			if( isRegistered(model) ){
				return ( _models[model] as ContextModelData ).manager;
			}else
				throw new RegisterError("The model '" + getQualifiedClassName(model) + "' is not registered." );			
		}
		
		/**
		 * Registers the Model classes with the Context.
		 * All Models must implement the IModel interface.
		 */
		public function register(...classes):void
		{
			var c:Class;
			// validate
			for each( c in classes ){
				if ( !isIModelClass(c) ) {
					throw new RegisterError( "Registered models must implement the '" + getQualifiedClassName(IModel) + "' interface. No models registered." );
				}
				if( isRegistered(c)){
					throw new RegisterError("The model '" + getQualifiedClassName(c) + "' has already been registered." ); 
				}
			}
			// register
			for each( c in classes ){
				const modelData:ContextModelData = new ContextModelData(c);
				contextInjector.injectInto(modelData);
				modelData.initialise();
				models[c] = modelData;
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
			for( var cls:Object in _models ){
				( _models[cls] as ContextModelData ).dispose();
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
	}
}
