package supply.core {
	import supply.api.IModelField;
	import supply.core.ns.supply_internal;
	import supply.fields.ArrayField;
	import supply.fields.BooleanField;
	import supply.fields.NumberField;
	import supply.fields.StringField;
	import supply.fields.intField;
	import supply.fields.uintField;
	import supply.queries.Query;
	import org.osflash.signals.ISignal;
	
	use namespace supply_internal;
	
	supply_internal class SupplyMain
	{
		
		// ---------------------------------------------------------------
		// >> SINGLETON ACCESS
		// ---------------------------------------------------------------	
			
		private static var _instance:SupplyMain;
		
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
			registerFields( ArrayField, BooleanField, intField, NumberField, StringField, uintField );
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
		
		// ---------------------------------------------------------------
		// >> PUBLIC METHODS
		// ---------------------------------------------------------------
		
		public function registerFields( ...fields ):Boolean
		{
			return Fields.registerFields( fields );
		}
		
		public function registerField( field:IModelField ):Boolean
		{
			return Fields.registerField(field);
		}
		
		public function registerStorage( ...storage ):void
		{
						
		}
		
		public function get query():Query
		{			
			return null;
		}
	}
}
