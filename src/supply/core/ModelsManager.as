package supply.core {
	import supply.Supply;
	import supply.api.IModel;
	import supply.core.ns.supply_internal;

	import flash.utils.Dictionary;
	import flash.utils.describeType;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	use namespace supply_internal;
		
	/**
	 * @author jamieowen
	 */
	public class ModelsManager
	{
		private var _reflectModelCache:Dictionary;
		
		public function ModelsManager()
		{		
			
		}
		
		public function reflectModelClass(model:Class) : ReflectedModel
		{
			if( _reflectModelCache == null ){
				_reflectModelCache = new Dictionary();
			}
			
			var reflectedModel:ReflectedModel = _reflectModelCache[model];
			
			if( reflectedModel ){
				return reflectedModel;
			}else{
				const type:XML = describeType(model);
				const IModelType:String = getQualifiedClassName(IModel);
		
				// check class implements interface
				const interfaces:XMLList = type.factory.implementsInterface;
				var isIModel:Boolean = false;
				for each( var i:XML in interfaces ){
					if( i.@type == IModelType ) { isIModel = true; break; }
				}
				
				if( !isIModel ){
					throw new Error("Supplied Model does not implement <IModel> interface.");
				}
				
				const fields:Vector.<ReflectedField> = new Vector.<ReflectedField>();
				var field:ReflectedField;		
				
				const elements:XMLList = type.factory.children().( name() == "variable" || name() == "accessor" );
				var element:XML;
				var metadata:XMLList;
				var arg:XML;
				var readonly:Boolean;
				var store:Boolean;
				
				for each( element in elements )
				{
					readonly = element.@access == "readonly" ? true : false;
					
					if( readonly ){
						continue;
					}

					store = true;
					
					// get supplied metadata args
					metadata = element.metadata.(@name =="Supply");
					if( metadata.length() == 1 )
					{
						for each( arg in metadata.arg ){
							switch( String(arg.@key) )
							{
								case "store" : 
									store = arg.@value == false ? false : true;
									break;
							}
						}
					}
					
					if( !store ){
						continue;
					}
					
					field = new ReflectedField();
					field.name = element.@name;
					field.type = element.@type;
					field.fieldHandler = Supply().fieldsManager.getFieldForType(field.type);
					if( field.fieldHandler == null ){
						Supply().warn( "No IModelField Handler for type : " + field.type );
					}
					fields.push( field );
				}
				
				reflectedModel = new ReflectedModel(model, fields);
				_reflectModelCache[model] = reflectedModel;	
				return reflectedModel;				
			}
						

		}
		
		public function reflectModelInstance(model:IModel) : ReflectedModel
		{
			const cls:Class = getDefinitionByName( getQualifiedClassName(model) ) as Class;
			return reflectModelClass(cls);
		}			
	}
}
import flash.utils.getQualifiedClassName;
import supply.api.IModelField;

internal class ReflectedField
{
	public var name:String;
	public var type:String;
	public var fieldHandler:IModelField;
		
	public function ReflectedField():void
	{
			
	}
		
	public function toString():String
	{
		return "[ModelField(name='" + name + "', type='" + type + "' )]";
	}
}

internal class ReflectedModel
{
	private var _fields:Vector.<ReflectedField>;
	private var _storageClass:Class;
	private var _model:Class;
	private var _fieldNames:Array; // a simple look up for just field names.
	private var _fieldNamesToFieldHandler:Object; // a lookup for a fieldname to its IModelField handler.
	
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
	
	public function get fields():Vector.<ReflectedField>
	{
		return _fields;
	}
		
	public function get storageClass():Class
	{
		return _storageClass;
	}
		
	public function ReflectedModel(model:Class, fields:Vector.<ReflectedField>)
	{
		_model = model;
		_fields = fields;
		_fieldNames = [];
			
		_fieldNamesToFieldHandler = {};
		
		var field:ReflectedField;
		for( var i:int = 0; i<_fields.length; i++ ){
			field = _fields[i];
			_fieldNames.push( field.name );
			_fieldNamesToFieldHandler[field.name] = field.fieldHandler;
		}
	}	
}
	
