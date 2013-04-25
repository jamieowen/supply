package supply.api
{

	public interface IModelField 
	{
		function getType():String;
		function toObject(model:IModel,fieldName:String):*;
		function fromObject(obj:*,model:IModel,fieldName:String):void;	
	}
}
