package supply {
	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;
	import supply.api.IModel;
	import supply.core.Fields;
	import supply.core.utils.uuid;
	import supply.core.ns.supply_internal;
	
	use namespace supply_internal;

	public class Model implements IModel
	{
		// ---------------------------------------------------------------
		// >> SIGNAL DECLARATIONS
		// ---------------------------------------------------------------
				
		private var _onSave:ISignal;
		private var _onDelete:ISignal;
		private var _onSync:ISignal;
		
		// ---------------------------------------------------------------
		// >> PRIVATE VARIABLES
		// ---------------------------------------------------------------		
		private var _cuid:String;
		private var _fields:Fields;
		
		// ---------------------------------------------------------------
		// >> SIGNAL GETTERS
		// ---------------------------------------------------------------
		
		/**
		 * 
		 */
		[Supply(store=false)]
		public function get onSave() : ISignal
		{
			if( _onSave == null )
				_onSave = new Signal(IModel);
			
			return _onSave;
		}
		
		[Supply(store=false)]
		public function get onDelete() : ISignal
		{
			if( _onDelete == null )
				_onDelete = new Signal(IModel);
		
			return _onDelete;
		}
		
		[Supply(store=false)]
		public function get onSync():ISignal
		{
			if( _onSync == null )
				_onSync = new Signal(IModel);
							
			return _onSync;
		}
		
		// ---------------------------------------------------------------
		// >> PUBLIC GETTERS
		// ---------------------------------------------------------------		
		
		public function get cuid():String
		{
			if( !_cuid ) 			 
			 _cuid = uuid();

			return _cuid;
		}
		
		public function set cuid(cuid:String):void
		{
			_cuid = cuid;
		}
		
		// ---------------------------------------------------------------
		// >> CONSTRUCTOR
		// ---------------------------------------------------------------	
				
		public function Model()
		{
			
		}
		
		// ---------------------------------------------------------------
		// >> MODEL OPERATIONS.
		// ---------------------------------------------------------------	
				
		public function save() : void
		{
			Supply.save(this);
		}

		public function del() : void
		{
			Supply.del(this);
		}
		
		public function sync():void
		{
			Supply.sync(this);
		}
		
		// ---------------------------------------------------------------
		// >> MODEL HELPERS. 
		// ---------------------------------------------------------------
		
		
		public function get fields():Fields
		{
			if( !_fields )
				_fields = new Fields(this);
			
			return _fields;
		}
	}
}
