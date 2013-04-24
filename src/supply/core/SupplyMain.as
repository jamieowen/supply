package supply.core {
	import supply.core.ns.supply_internal;
	import supply.fields.ArrayField;
	import supply.fields.BooleanField;
	import supply.fields.NumberField;
	import supply.fields.StringField;
	import supply.fields.intField;
	import supply.fields.uintField;
	import supply.queries.Query;

	import org.osflash.signals.ISignal;

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
			registerFields( ArrayField, BooleanField, intField, NumberField, StringField, uintField  )
		}
		
		// ---------------------------------------------------------------
		// >> SUPPLY INTERNAL METHODS
		// ---------------------------------------------------------------		
		
		supply_internal function setOperatingModelClass(model : Class) : void
		{
			
		}
		
		supply_internal function clearOperatingModelClass() : void
		{
			
		}		
		
		// ---------------------------------------------------------------
		// >> PUBLIC METHODS
		// ---------------------------------------------------------------
		
		public function registerFields( ...fields ):void
		{
			
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
