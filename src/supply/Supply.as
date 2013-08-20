package supply {
	import supply.queries.Collection;
	import supply.api.ICollection;
	import supply.queries.Query;
	import supply.api.IModel;
	import supply.api.IStorage;
	import supply.core.managers.FieldsManager;
	import supply.core.managers.ModelsManager;
	import supply.core.managers.StorageManager;
	import supply.core.ns.supply_internal;
	import supply.fields.ArrayField;
	import supply.fields.BooleanField;
	import supply.fields.DateField;
	import supply.fields.NumberField;
	import supply.fields.StringField;
	import supply.fields.VectorField;
	import supply.fields.XMLField;
	import supply.fields.intField;
	import supply.fields.uintField;
	import supply.storage.FileStorage;

	import org.osflash.signals.ISignal;

	
	use namespace supply_internal;
	
	public class Supply
	{
		// ---------------------------------------------------------------
		// >> SINGLETON ACCESS
		// ---------------------------------------------------------------	
		
		private static var _canInsantiate:Boolean = false;
		private static var _instance:Supply;
		
		private static function getInstance():Supply
		{
			if( !_instance ){
				_canInsantiate = true;
				_instance = new Supply();
				_canInsantiate = false;
				
				_instance.initialize();
			}
			return _instance;
		}
		
		// ---------------------------------------------------------------
		// >> PUBLIC API STATIC METHODS 
		// ---------------------------------------------------------------	
			
		public static function get onSave():ISignal
		{
			return Supply.getInstance().onSave;
		}
		
		public static function get onDelete():ISignal
		{
			return Supply.getInstance().onDelete;
		}		

		public static function get onSync():ISignal
		{
			return Supply.getInstance().onSync;
		}		
		
		public static function get onSaved():ISignal
		{
			return Supply.getInstance().onSaved;
		}
		
		public static function get onDeleted():ISignal
		{
			return Supply.getInstance().onDeleted;
		}		

		public static function get onSynced():ISignal
		{
			return Supply.getInstance().onSynced;
		}
		
		public static function save(model:IModel) : void
		{
			Supply.getInstance().save(model);
		}
		
		/**
		 * Deletes a Model from the Storage associated with it.
		 */
		public static function del(model:IModel) : void
		{
			Supply.getInstance().del(model);
		}
		
		/**
		 * Syncs ( reverts ) the Model with the current version in Storage.
		 */
		public static function sync(model:IModel) : void
		{
			Supply.getInstance().sync(model);
		}
		
		/**
		 * Starts a Storage Query on the Model specified.
		 */
		public static function query( modelClass:Class ):Query
		{			
			return Supply.getInstance().query(modelClass);
		}
		
		/**
		 * Used by Collection and Query classes to refresh or complete a Query.
		 */
		supply_internal static function executeQuery(storage : String, query : Query, collection : ICollection = null) : ICollection
		{			
			return Supply.getInstance().executeQuery(storage, query, collection);
		}		
			
		supply_internal static function warn(message:*) : void
		{
			Supply.getInstance().warn(message);
		}
		
		supply_internal static function log(message:*) : void
		{
			Supply.getInstance().log(message);
		}
		
		supply_internal static function debug(message:*) : void
		{
			Supply.getInstance().debug(message);
		}
				
		public static function get fieldsManager():FieldsManager
		{
			return Supply.getInstance().fieldsManager;		
		}
		
		public static function get modelsManager():ModelsManager
		{
			return Supply.getInstance().modelsManager;
		}
		
		public static function get storageManager():StorageManager
		{
			return Supply.getInstance().storageManager;
		}
		// ---------------------------------------------------------------
		// >> SINGLETON INSTANCE VARIABLES & METHODS
		// ---------------------------------------------------------------			
		
		// ---------------------------------------------------------------
		// >> GLOBAL SIGNALS 
		// ---------------------------------------------------------------
		
		public var onSave:ISignal;
		public var onDelete:ISignal;
		public var onSync:ISignal;
		public var onSaved:ISignal;
		public var onDeleted:ISignal;
		public var onSynced:ISignal;
		
		// ---------------------------------------------------------------
		// >> MANAGERS
		// ---------------------------------------------------------------		
		
		public var fieldsManager:FieldsManager;
		public var modelsManager:ModelsManager;
		public var storageManager:StorageManager;	
		
		// ---------------------------------------------------------------
		// >> MISC VARS
		// ---------------------------------------------------------------
		private var _initialized:Boolean = false;
		
		// ---------------------------------------------------------------
		// >> CONSTRUCTOR
		// ---------------------------------------------------------------
								
		public function Supply()
		{
			if( !Supply._canInsantiate )
			{
				throw new Error("The Supply instance cannot be instantiated manually.");
			}
		}
		
		// ---------------------------------------------------------------
		// >> INITIALIZE
		// ---------------------------------------------------------------
				
		public function initialize():void
		{
			if( _initialized ){
				return;
			}
			
			_initialized = true;
			
			fieldsManager	 	= new FieldsManager();
			modelsManager 		= new ModelsManager();
			storageManager 		= new StorageManager();
			
			fieldsManager.registerFields( BooleanField, intField, uintField, NumberField, StringField, XMLField, DateField, ArrayField, VectorField );
			storageManager.registerStorages( FileStorage );
		}
		
		// ---------------------------------------------------------------
		// >> REGISTER METHODS.
		// ---------------------------------------------------------------
		
		public function registerFields( ...fields ):Boolean
		{
			return fieldsManager.registerFields.apply( fieldsManager, fields );
		}
		
		
		public function registerStorage( ...storage ):Boolean
		{
			return storageManager.registerStorages.apply( storageManager, storage );		
		}		
		
		// ---------------------------------------------------------------
		// >> MODEL ACCESS METHODS
		// ---------------------------------------------------------------
		
		/**
		 * Saves a Model to the Storage associated with it.
		 */
		public function save(model:IModel) : void
		{
			var storage:IStorage = storageManager.getStorage(model);
			storage.save(model);
		}
		
		/**
		 * Deletes a Model from the Storage associated with it.
		 */
		public function del(model:IModel) : void
		{
			
		}
		
		/**
		 * Syncs ( reverts ) the Model with the current version in Storage.
		 */
		public function sync(model:IModel) : void
		{
			
		}
		
		/**
		 * Starts a Storage Query on the Model specified.
		 */
		public function query( modelClass:Class ):Query
		{			
			return new Query(null, null);
		}
		
		/**
		 * Used by Collection and Query classes to refresh or complete a Query.
		 */
		supply_internal function executeQuery(storage : String, query : Query, collection : ICollection = null) : ICollection
		{			
			if( collection == null ){
				collection = defaultCollectionFactory(query);
			}
			
			return collection;
		}		
						
		// ---------------------------------------------------------------
		// >> FACTORY METHODS
		// ---------------------------------------------------------------
		
		/**
		 * Defines the default factory for creating Collections.
		 */			
		private function defaultCollectionFactory(query:Query):ICollection
		{
			return new Collection(query);
		}		
		
		
		// ---------------------------------------------------------------
		// >> LOG METHODS.
		// ---------------------------------------------------------------
				
		supply_internal function warn(message:*) : void
		{
			trace( "(Supply) warn : " + message );
		}
		
		supply_internal function log(message:*) : void
		{
			trace( "(Supply) log : " + message );
		}
		
		supply_internal function debug(message:*) : void
		{
			trace( "(Supply) warn : " + message );
		}
	}
}
