package supply.reflect {
	import flash.utils.describeType;
	import supply.api.IModel;
	import flash.utils.getQualifiedClassName;
	/**
	 * @author jamieowen
	 */
	public function isModelClass(cls:Class) : Boolean
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
}
