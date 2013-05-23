package supply.core.reflect 
{
	import supply.core.utils.msid;
	import flash.utils.getQualifiedClassName;
	import supply.api.IModelField;
	
	public class ReflectedModel
	{
		private var _msid:String;
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
		
		public function get className():String
		{
			var type:String = type;
			if( type.indexOf("::") != -1 ){
				return type.split("::").slice(-1).pop();
			}else{
				return type;			
			}
		}
		
		public function get fieldNames():Array
		{
			return _fieldNames;
		}
		
		public function get type():String
		{
			return getQualifiedClassName(_model);
		}
		
		public function get msid():String
		{
			if( _msid == null ){
				_msid = supply.core.utils.msid(this);	
			}
			
			return _msid;
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
			if( _storageConfig == null ){
				_storageConfig = {};
			}
			// check for name default.
			if( _storageConfig["storage"] == null ){
				_storageConfig["storage"] = "file";
			}
			
			return _storageConfig;
		}
			
		public function ReflectedModel(model:Class, fields:Vector.<ReflectedField>,storageConfig:Object)
		{
			_model = model;
			_fields = fields;
			_fieldNames = [];
			
			_storageConfig = storageConfig;
				
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
