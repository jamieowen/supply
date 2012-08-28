package supply.api {
	import supply.storage.request.Request;
	/**
	 * @author jamieowen
	 */
	public interface ISerializer
	{
		function serialize(model:IModel):*;
		function serializeMany(models:Vector.<IModel>):*;

		/**
		 * @param subRequest A list of subrequests that need to be called to fully deserialize an object. I.e so foreign models can be requested.
		 */
		function deserialize(data:*, subRequests:Vector.<Request>):IModel;
		/**
		 * @param subRequest A list of subrequests that need to be called to fully deserialize an object. I.e so foreign models can be requested.
		 */
		function deserializeMany( data:*, subRequest:Vector.<Request> ):Vector.<IModel>;
	}
}
