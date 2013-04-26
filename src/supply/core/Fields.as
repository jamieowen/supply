package supply.core {
	import supply.api.IModel;

	import supply.core.ns.supply_internal;

	use namespace supply_internal;
	
	public class Fields
	{

		
		// ---------------------------------------------------------------
		// >> PRIVATE VARIABLES
		// ---------------------------------------------------------------	
				
		private var _model:IModel;
		
		// ---------------------------------------------------------------
		// >> PUBLIC GETTERS
		// ---------------------------------------------------------------	
		
		public function get numFields():uint
		{
			return ModelsManager.reflectModelInstance(_model).fieldNames.length;
		}
		
		public function get fieldNames():Array
		{
			return ModelsManager.reflectModelInstance(_model).fieldNames;
		}
		
						
		// ---------------------------------------------------------------
		// >> CONSTRUCTOR
		// ---------------------------------------------------------------	
				
		public function Fields(model:IModel)
		{
			_model = model;
		}
		
		// ---------------------------------------------------------------
		// >> PUBLIC METHODS
		// ---------------------------------------------------------------			
		
		/**
		 * 
		 */
		public function getFieldNameAt(index:uint):String
		{
			return ModelsManager.reflectModelInstance(_model).fieldNames[index];
		}
		
		public function getSyncValue(fieldName:String):*
		{
			return null;
		}
		
		public function isDirty(fieldName:String = null ):Boolean
		{
			return null;
		}
		
		public function getValue(fieldName:String ):*
		{
			return _model[fieldName];
		}
		
		public function toObject():Object
		{
			return null;
		}
		
		public function fromObject(object:Object):void
		{
			
		}
		
		
		// ---------------------------------------------------------------
		// >> PRIVATE METHODS
		// ---------------------------------------------------------------
		
	}
}

