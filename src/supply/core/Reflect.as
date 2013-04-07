package supply.core {
	import flash.utils.getDefinitionByName;
	import supply.api.IModel;
	import flash.utils.getQualifiedClassName;
	import flash.utils.describeType;
	import supply.errors.ReflectionError;
	
	/**
	 * @author jamieowen
	 */
	public class Reflect
	{
		public static function isIModelClass(cls:Class) : Boolean
		{
			var type:XML = describeType(cls);
			var IModelType:String = getQualifiedClassName(IModel);
			
			// check class implements interface
			var interfaces:XMLList = type.factory.implementsInterface;
			var isIModel:Boolean = false;
			for each( var i:XML in interfaces ){
				if( i.@type == IModelType ) { isIModel = true; break; }
			}
			
			return isIModel;
		}
		
		public static function reflectPropertiesFromModelClass(cls:Class) : Vector.<ReflectedProperty>
		{
			var type:XML = describeType(cls);
			var IModelType:String = getQualifiedClassName(IModel);
	
			// check class implements interface
			var interfaces:XMLList = type.factory.implementsInterface;
			var isIModel:Boolean = false;
			for each( var i:XML in interfaces ){
				if( i.@type == IModelType ) { isIModel = true; break; }
			}
			
			if( !isIModel ){
				throw new ReflectionError("Supplied model does not implement <IModel> interface.");
			}
			
			var properties:Vector.<ReflectedProperty> = new Vector.<ReflectedProperty>();
			var property:ReflectedProperty;		
			
			var elements:XMLList = type.factory.children().( name() == "variable" || name() == "accessor" );
			var element:XML;
			var metadata:XMLList;
			var arg:XML;
			
			for each( element in elements )
			{
				property = new ReflectedProperty();
				
				property.name = element.@name;
				property.type = element.@type;
				property.readonly = element.@access == "readonly" ? true : false;
				
				// set default metadata supplied args
				property.store = true;
				
				// get supplied metadata args
				metadata = element.metadata.(@name =="Supply");
				if( metadata.length() == 1 )
				{
					for each( arg in metadata.arg ){
						switch( String(arg.@key) )
						{
							case "store" : 
								property.store = arg.@value == false ? false : true;
								break;
						}
					}
				}
				
				properties.push( property );
			}
				
			return properties;
		}
		
		public static function reflectPropertiesFromModelInstance(model:IModel) : Vector.<ReflectedProperty>
		{
			const cls:Class = getDefinitionByName( getQualifiedClassName(model) ) as Class;
			return reflectPropertiesFromModelClass(cls);
		}			
	}
}

internal class ReflectedProperty
{
	public var name:String;
	public var type:String;
	public var store:Boolean;
	public var readonly:Boolean;
	public var isForeignKey:Boolean; // indicates if the type is a model managed by this context.
		
	public function ReflectedProperty():void
	{
			
	}
		
	public function toString():String
	{
		return "[ModelProperty(name='" + name + "', readonly='" + readonly + "', store='" + store + "', type='" + type + "' )]";
	}
}

internal class ReflectedModel
{
	private var _properties:Vector.<ReflectedProperty>;
	private var _storageClass:Class;
		
	public function get properties():Vector.<ReflectedProperty>
	{
		return _properties;
	}
		
	public function get storageClass():Class
	{
		return _storageClass;
	}
		
	public function ReflectedModel(model:Class, properties:Vector.<ReflectedProperty>)
	{
		_properties = properties;
	}	
}
	