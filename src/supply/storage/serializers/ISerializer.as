package supply.storage.serializers {
	/**
	 * @author jamieowen
	 */
	public interface ISerializer
	{
		function get name():String;
		function serialize(obj:Object):*;
		function deserialize(obj:*):Object;
	}
}
