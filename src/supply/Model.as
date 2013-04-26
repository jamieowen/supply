package supply {
	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;
	import supply.api.IModel;
	import supply.core.Fields;
	import supply.core.utils.uuid;


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
			return _onSave;
		}
		
		[Supply(store=false)]
		public function get onDelete() : ISignal
		{
			return _onDelete;
		}
		
		[Supply(store=false)]
		public function get onSync():ISignal
		{
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
		
		// ---------------------------------------------------------------
		// >> CONSTRUCTOR
		// ---------------------------------------------------------------	
				
		public function Model()
		{
			 _onSave = new Signal(IModel);
			 _onDelete = new Signal(IModel);
			 _onSync = new Signal(IModel);
		}
		
		// ---------------------------------------------------------------
		// >> MODEL OPERATIONS.
		// ---------------------------------------------------------------	
				
		public function save() : void
		{
			
		}

		public function del() : void
		{
			
		}
		
		public function sync():void
		{
			
		}
		
		// ---------------------------------------------------------------
		// >> MODEL HELPERS. 
		// ---------------------------------------------------------------
		
		
		public function get fields():Fields
		{
			if( !_fields ){
				_fields = new Fields(this);
			}
			
			return _fields;
		}
		
		
		/**public function validation():*
		{
			// different release...
			// later...			
		}**/
	}
}
