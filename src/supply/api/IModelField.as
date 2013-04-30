package supply.api
{

	public interface IModelField 
	{
		function handlesType(type:String):Boolean;
		function toObject(value:*, type:String):*;
		function fromObject(value:*, type:String):*;
		
		/**
		 * Tests if the field is equal to two serialized versions of the the field.
		 */
		function isEqual(obj1:*,obj2:*, type:String):Boolean;	
	}
}
