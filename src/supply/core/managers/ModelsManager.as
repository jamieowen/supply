package supply.core.managers {
	import supply.Supply;
	import supply.api.IModel;
	import supply.core.ns.supply_internal;
	import supply.core.reflect.ReflectedField;
	import supply.core.reflect.ReflectedModel;

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
		
		private function parseArg( arg:String ):*
		{
			if( arg.toLowerCase() == "true" ){
				return true;
			}else if( arg.toLowerCase() == "false" ){
				return false;
			}else
			{
				var float:Number = parseFloat(arg);
				if( !isNaN(float) ){
					return float;
				}else{
					return arg;	
				}
			}
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
				var storageConfig:Object = {};
				
				// storage metadata
				metadata = type.factory.children().( name() == "metadata" ).(@name=="Supply");
				if( metadata.length() == 1)
				{
					for each( arg in metadata.arg ){
						storageConfig[arg.@key] = parseArg( arg.@value.toString() );
					}
				}
				
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
					field.fieldHandler = Supply.fieldsManager.getFieldForType(field.type);
					if( field.fieldHandler == null ){
						Supply.warn( "No IModelField Handler for type : " + field.type );
					}
					fields.push( field );
				}
				
				reflectedModel = new ReflectedModel(model, fields, storageConfig);
				_reflectModelCache[model] = reflectedModel;	
				return reflectedModel;				
			}
						

		}
		
		public function reflect(model:IModel) : ReflectedModel
		{
			const cls:Class = getDefinitionByName( getQualifiedClassName(model) ) as Class;
			return reflectModelClass(cls);
		}
		
	}
}



	