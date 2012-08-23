package supply.core {
	import supply.api.IModel;
	import supply.errors.ReflectionError;
	import supply.core.reflect.ReflectedProperty;
	import flash.utils.getQualifiedClassName;
	import flash.utils.describeType;
	import supply.core.reflect.ReflectedModel;
	/**
	 * @author jamieowen
	 */
	public class ReflectionManager
	{
		[Inject]
		public var contextModelManager:ContextModelManager;
		
		public function ReflectionManager()
		{
			
		}
		
		public function reflect( model:Class ):ReflectedModel
		{
			var properties:Vector.<ReflectedProperty> = reflectPropertiesFromModelClass(model);
			return new ReflectedModel(model, properties);
		}
		
		
		public function reflectPropertiesFromModelClass(cls:Class) : Vector.<ReflectedProperty>
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
			var modelData:ContextModelData;
			
			for each( element in elements )
			{
				property = new ReflectedProperty();
				
				property.name = element.@name;
				property.type = element.@type;
				
				// check foreign key
				modelData = contextModelManager.getDataForType(property.type);
				if( modelData )
					property.isForeignKey = true;
				else
					property.isForeignKey = false;
				
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
	}
}
