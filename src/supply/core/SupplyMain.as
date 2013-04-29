package supply.core {
	import supply.fields.DateField;
	import supply.api.IModelField;
	import supply.core.ns.supply_internal;
	import supply.fields.ArrayField;
	import supply.fields.BooleanField;
	import supply.fields.NumberField;
	import supply.fields.StringField;
	import supply.fields.VectorField;
	import supply.fields.XMLField;
	import supply.fields.intField;
	import supply.fields.uintField;

	import org.osflash.signals.ISignal;
	
	use namespace supply_internal;
	
	public class SupplyMain
	{
		
		// ---------------------------------------------------------------
		// >> SINGLETON ACCESS
		// ---------------------------------------------------------------	
			
		private static var _instance:SupplyMain;
		
		public static function getInstance():SupplyMain
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
			_fieldsManager = new FieldsManager();
			_modelsManager = new ModelsManager();
			
			registerFields( BooleanField, intField, uintField, NumberField, StringField, XMLField, DateField, ArrayField, VectorField );
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
			return _fieldsManager;
		}
	
		supply_internal function get modelsManager() : ModelsManager
		{
			return _modelsManager;
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
		
		public function registerField( field:IModelField ):Boolean
		{
			return fieldsManager.registerField(field);
		}
		
		public function registerStorage( ...storage ):void
		{
						
		}
		
		/**public function get query():Query
		{			
			return null;
		}**/
	}
}
