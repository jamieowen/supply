package supply.storage {
	import supply.api.IStorage;
	import flash.utils.describeType;
	import flash.utils.getQualifiedClassName;
	/**
	 * @author jamieowen
	 */
	public function isIStorageClass(cls:Class) : Boolean
	{
		var type:XML = describeType(cls);
		var IStorageType:String = getQualifiedClassName(IStorage);
		
		// check class implements interface
		var interfaces:XMLList = type.factory.implementsInterface;
		var isIStorage:Boolean = false;
		for each( var i:XML in interfaces ){
			if( i.@type == IStorageType ) { isIStorage = true; break; }
		}
		
		return isIStorage;
	}
}
