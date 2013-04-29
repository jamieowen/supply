package supply.core
{
	import supply.api.IModelField;
	
	public class FieldsManager
	{
		private var _fieldTypes:Vector.<IModelField>;
		
		public function FieldsManager()
		{
			
		}
		
		public function getFieldForType(type:String):IModelField
		{
			if( type == null ){
				return null;
			}
			
			for( var i:int = 0; i<_fieldTypes.length; i++ )
			{
				if( _fieldTypes[i].handlesType(type) )
				{
					return _fieldTypes[i];
				}
			}
			
			return null;
			
			// throw new Error("Cannot find the IModelField for type: " + type + ".  If it is a custom type, register the IModelField class for it first" );
		}
		
		public function registerField(field : IModelField) : Boolean
		{ 
			if( !field ){
				return false;
			}
			if( !_fieldTypes ){
				_fieldTypes = new Vector.<IModelField>();
			}
			
			_fieldTypes.push(field);
			return true;
			
			/**if( getFieldForType(field.getType()) == null )
			{
				
				return true;
			}else
			{
				throw new Error("Cannot register Field.  Field type already has a handler for it.");
				return false;
			}**/
		}
		
		public function registerFields(...fields):Boolean
		{
			if( fields == null ){
				return false;	
			}
			
			var field:IModelField;
			var success:Boolean = true;
			var fieldAsClass:Class;
			for( var i:int = 0; i<fields.length; i++ )
			{
				fieldAsClass = fields[i] as Class;
				if( fieldAsClass ){
					field = new fieldAsClass();
				}else{
					field = fields[i] as IModelField;	
				}
				
				success = success && registerField(field);
			}
			
			return success;			
		}		
	}
}
