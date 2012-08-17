package supply.serialization {
	import flash.utils.describeType;
	import flash.utils.getQualifiedClassName;
	import supply.api.ISerializer;
	/**
	 * @author jamieowen
	 */
	public function isISerializerClass(cls:Class) : Boolean
	{
		var type:XML = describeType(cls);
		var ISerializationType:String = getQualifiedClassName(ISerializer);
		
		// check class implements interface
		var interfaces:XMLList = type.factory.implementsInterface;
		var isISerialization:Boolean = false;
		for each( var i:XML in interfaces ){
			if( i.@type == ISerializationType ) { isISerialization = true; break; }
		}
		
		return isISerialization;
	}
}
