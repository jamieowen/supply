package supply.api
{

	public interface IModelField 
	{
		function handlesType(type:String):Boolean;
		function toObject(value:*, type:String):*;
		function fromObject(value:*, type:String):*;	
	}
}
