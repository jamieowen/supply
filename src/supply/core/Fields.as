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
			for( var i:int = 0; i<_fields.length; i++ )
			{
				if( _fields[i].getType() == type )
				{
					return _fields[i];
				}
			}
			
			throw new Error("Cannot find the IModelField for type: " + type + ".  If it is a custom type, register the IModelField class for it first" );
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
		
		supply_internal static function registerFields(...fields):Boolean
		{
			if( fields == null ){
				return false;	
			}
			
			var field:IModelField;
			var success:Boolean = true;
			for( var i:int = 0; i<fields.length; i++ )
			{
				field = fields[fields] as IModelField;
				success = success && registerField(field);
			}
			
			return success;			
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
		
		private function get fieldsMap():Object		
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
			return null;
		}
		
		public function toObject():Object
		{
			return null;
		}
		
		public function fromObject(object:Object):void
		{
			
		}
		
		public function getRelations(fieldName:String = null):void
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
