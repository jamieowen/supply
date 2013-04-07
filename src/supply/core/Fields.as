package supply.core {
	import supply.api.IModel;

	public class Fields
	{
		// ---------------------------------------------------------------
		// >> PRIVATE VARIABLES
		// ---------------------------------------------------------------	
				
		private var _model:IModel;
		private var _fields:Object;
		
		// ---------------------------------------------------------------
		// >> PUBLIC GETTERS
		// ---------------------------------------------------------------	
		
		public function get count():uint
		{
			return 0;	
		}
		
		// ---------------------------------------------------------------
		// >> PRIVATE GETTERS
		// ---------------------------------------------------------------
		
		public function get fields():Object		
		{
			if( _fields == null ){
				_fields = buildFieldMap(_model)	;
			}
			return _fields;
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
		
		public function getFieldNameAt(index:uint):String
		{
			return null;
		}
		
		public function getSyncValue(property:String):*
		{
			return null;
		}
		
		public function isDirty( property:String = null ):Boolean
		{
			return null;
		}
		
		public function getValue( property:String ):*
		{
			return null;
		}
		
		public function toObject():Object
		{
			return null;
		}
		
		public function fromObject(object:Object):void
		{
			
		}
		
		public function getRelations(property:String = null):void
		{
			
		}
		
		// ---------------------------------------------------------------
		// >> PRIVATE METHODS
		// ---------------------------------------------------------------
		
		public function buildFieldMap(model:IModel):Object
		{
			return null;
		}
	}
}
import supply.api.IModelField;

internal class FieldLookupItem
{
	public var property:String;
	public var fieldHandler:IModelField;
	
	public function FieldLookupItem()
	{
		
	}
}
