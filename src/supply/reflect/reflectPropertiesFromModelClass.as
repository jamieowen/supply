package supply.reflect
{
	import supply.errors.ReflectionError;
	import supply.api.IModel;
	import avmplus.getQualifiedClassName;
	import flash.utils.describeType;
	/**
	 * @author jamieowen
	 */
	public function reflectPropertiesFromModelClass(cls:Class) : Vector.<ReflectProperty>
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
		
		var properties:Vector.<ReflectProperty> = new Vector.<ReflectProperty>();
		var property:ReflectProperty;		
		
		var elements:XMLList = type.factory.children().( name() == "variable" || name() == "accessor" );
		var element:XML;
		var metadata:XMLList;
		var arg:XML;
		
		for each( element in elements )
		{
			property = new ReflectProperty();
			
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
	
	
}
