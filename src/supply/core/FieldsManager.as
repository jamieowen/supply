package supply.core
{
	import supply.api.IModelField;
	import supply.core.ns.supply_internal;

	use namespace supply_internal;
	
	supply_internal class FieldsManager
	{
		private static var _fieldTypes:Vector.<IModelField>;
		
		public static function getFieldForType(type:String):IModelField
		{
			for( var i:int = 0; i<_fieldTypes.length; i++ )
			{
				if( _fieldTypes[i].getType() == type )
				{
					return _fieldTypes[i];
				}
			}
			
			throw new Error("Cannot find the IModelField for type: " + type + ".  If it is a custom type, register the IModelField class for it first" );
		}
		
		public static function registerField(field : IModelField) : Boolean
		{ 
			if( !field ){
				return false;
			}
			if( !_fieldTypes ){
				_fieldTypes = new Vector.<IModelField>();
			}
			
			if( getFieldForType(field.getType()) == null )
			{
				_fieldTypes.push(field);
				return true;
			}else
			{
				throw new Error("Cannot register Field.  Field type already has a handler for it.");
				return false;
			}
		}
		
		public static function registerFields(...fields):Boolean
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
	}
}
