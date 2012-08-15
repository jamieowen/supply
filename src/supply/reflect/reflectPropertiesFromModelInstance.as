package supply.reflect {
	import avmplus.getQualifiedClassName;
	import flash.utils.getDefinitionByName;
	import supply.api.IModel;
	
	/**
	 * @author jamieowen
	 */
	public function reflectPropertiesFromModelInstance(model:IModel) : Vector.<ReflectProperty>
	{
		const cls:Class = getDefinitionByName( getQualifiedClassName(model) ) as Class;
		return reflectPropertiesFromModelClass(cls);
	}
}
