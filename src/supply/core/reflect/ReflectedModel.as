package supply.core.reflect 
{
	import supply.api.IModelField;
	
	public class ReflectedModel
	{
		private var _fields:Vector.<ReflectedField>;
		private var _storageConfig:Object;
		private var _model:Class;
		private var _fieldNames:Array; // a simple look up for just field names.
		private var _fieldNamesToFieldHandler:Object; // a lookup for a fieldname to its IModelField handler.
		private var _fieldNamesToReflectedField:Object;
		
		public function getFieldHandler(fieldName:String):IModelField
		{
			return _fieldNamesToFieldHandler[fieldName] as IModelField;
		}
		
		public function get model():Class
		{	
			return _model;	
		}
		
		public function get fieldNames():Array
		{
			return _fieldNames;
		}
		
		public function getField(fieldName:String):ReflectedField
		{
			return _fieldNamesToReflectedField[fieldName];
		}
		
		public function get fields():Vector.<ReflectedField>
		{
			return _fields;
		}
			
		public function get storageConfig():Object
		{
			return _storageConfig;
		}
			
		public function ReflectedModel(model:Class, fields:Vector.<ReflectedField>)
		{
			_model = model;
			_fields = fields;
			_fieldNames = [];
				
			_fieldNamesToFieldHandler = {};
			_fieldNamesToReflectedField = {};
			
			var field:ReflectedField;
			for( var i:int = 0; i<_fields.length; i++ ){
				field = _fields[i];
				_fieldNames.push( field.name );
				_fieldNamesToFieldHandler[field.name] = field.fieldHandler;
				_fieldNamesToReflectedField[field.name] = field;
			}
		}	
	}
}
