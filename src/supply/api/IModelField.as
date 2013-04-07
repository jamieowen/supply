package supply.api
{

	public interface IModelField 
	{
		function getType():String;
		function toObject():*;
		function fromObject(obj:*):void;	
	}
}
