package supply.api
{

	public interface IModelField 
	{
		function handlesType(type:String):Boolean;
		function toObject(model:IModel,fieldName:String):*;
		function fromObject(obj:Object,model:IModel,fieldName:String):void;	
	}
}
