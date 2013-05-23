package supply.core {
	import supply.api.IStorage;
	import org.osflash.signals.ISignal;
	import supply.api.IModel;
	import supply.api.IModelField;
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

	
	use namespace supply_internal;
	
	public class SupplyMain
	{
		
		// ---------------------------------------------------------------
		// >> SINGLETON ACCESS
		// ---------------------------------------------------------------	
			
		supply_internal static var _instance:SupplyMain;
		
		supply_internal static function getInstance():SupplyMain
		{
			if( !_instance ){
				_instance = new SupplyMain();
			}
			return _instance;
		}
		
		// ---------------------------------------------------------------
		// >> PRIVATE VARIABLES
		// ---------------------------------------------------------------
		
		private var _onSave:ISignal;
		private var _onDelete:ISignal;
		private var _onSync:ISignal;
		private var _onSaved:ISignal;
		private var _onDeleted:ISignal;
		private var _onSynced:ISignal;
		
		private var _fieldsManager:FieldsManager;
		private var _modelsManager:ModelsManager;
		private var _storageManager:StorageManager;	
		
		// ---------------------------------------------------------------
		// >> PUBLIC GETTERS
		// ---------------------------------------------------------------		
		
		public function get onSave():ISignal
		{
			return _onSave;
		}
		
		public function get onDelete():ISignal
		{
			return _onDelete;
		}	
		
		public function get onSync():ISignal
		{
			return _onSync;
		}
		
		public function get onSaved():ISignal
		{
			return _onSaved;
		}
		
		public function get onDeleted():ISignal
		{
			return _onDeleted;
		}	
		
		public function get onSynced():ISignal
		{
			return _onSynced;
		}		
		
		// ---------------------------------------------------------------
		// >> CONSTRUCTOR
		// ---------------------------------------------------------------
								
		public function SupplyMain()
		{
			
		}
		
		// ---------------------------------------------------------------
		// >> SUPPLY INTERNAL METHODS
		// ---------------------------------------------------------------		
		
		supply_internal function pushOperatingModelClass(model : Class) : void
		{
			
		}
		
		supply_internal function popOperatingModelClass() : void
		{
			
		}
		
		supply_internal function get fieldsManager() : FieldsManager
		{
			if( _fieldsManager == null ){
				_fieldsManager = new FieldsManager();
				_fieldsManager.registerFields( BooleanField, intField, uintField, NumberField, StringField, XMLField, DateField, ArrayField, VectorField );
			}
			return _fieldsManager;
		}
	
		supply_internal function get modelsManager() : ModelsManager
		{
			if( _modelsManager == null ){
				_modelsManager = new ModelsManager();
			}
			return _modelsManager;
		}
		
		supply_internal function get storageManager() : StorageManager
		{
			if( _storageManager == null ){
				_storageManager = new StorageManager();
				_storageManager.registerStorages( FileStorage );
			}
			return _storageManager;
		}		
		
		supply_internal function save(model:IModel) : void
		{
			var storage:IStorage = storageManager.getStorage(model);
			storage.save(model);
		}
		
		supply_internal function del(model:IModel) : void
		{
			
		}

		supply_internal function sync(model:IModel) : void
		{
			
		}
				
		supply_internal function warn(message:*) : void
		{
			trace( "(Supply) warn : " + message );
		}		
		
		// ---------------------------------------------------------------
		// >> PUBLIC METHODS
		// ---------------------------------------------------------------
		
		public function registerFields( ...fields ):Boolean
		{
			return fieldsManager.registerFields.apply( _fieldsManager, fields );
		}
		
		
		public function registerStorage( ...storage ):Boolean
		{
			return storageManager.registerStorages.apply( _storageManager, storage );		
		}
		
		/**public function get query():Query
		{			
			return null;
		}**/
	}
}
