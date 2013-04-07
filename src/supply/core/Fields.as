package supply.core {
	import supply.core.ns.supply_internal;
	import supply.api.IModelField;
	import supply.api.IModel;

	use namespace supply_internal;
	
	public class Fields
	{
		supply_internal static var _fields:Vector.<IModelField>;
		
		supply_internal static function getFieldForType(type:String):IModelField
		{
			return null;
		}
		
		supply_internal static function registerField(field : IModelField) : Boolean
		{ 
			if( !field ){
				return false;
			}
			if( !_fields ){
				_fields = new Vector.<IModelField>();
			}
			
			if( getFieldForType(field.getType()) == null )
			{
				_fields.push(field);
				return true;
			}else
			{
				throw new Error("Cannot register Field.  Field type already has a handler for it.");
				return false;
			}
		}
		
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
		
		private function get fields():Object		
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
