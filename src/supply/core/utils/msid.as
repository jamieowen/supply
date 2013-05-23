package supply.core.utils
{
	import supply.core.lib.MD5;
	import supply.core.reflect.ReflectedModel;
	/**
	 * Generates a unique model schema id for a reflected model.
	 * This is to determine if a model's field has changed for migration purposes.
	 */
	public function msid(reflected:ReflectedModel) : String {
		
		var fieldName:String;
		var fieldNames:Array = reflected.fieldNames.slice(0);
		fieldNames.sort(Array.DESCENDING);
		
		var msid:String = "";
		for( var i:int = 0; i<fieldNames.length;i++ )
		{
			fieldName = fieldNames[i];
			msid += fieldName + reflected.getField(fieldName).type;
		}
		
		return MD5.hash(msid);
	}
}
