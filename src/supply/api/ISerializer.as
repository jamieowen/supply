package supply.api {
	/**
	 * @author jamieowen
	 */
	public interface ISerializer
	{
		function serialize(model:IModel):*
		function serializeMany( models:Vector.<IModel>):*;
		function deserialize(data:*):IModel;
		function deserializeMany( data:* ):Vector.<IModel>;
	}
}
