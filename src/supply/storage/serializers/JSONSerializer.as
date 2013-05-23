package supply.storage.serializers {
	import supply.storage.serializers.ISerializer;

	/**
	 * @author jamieowen
	 */
	public class JSONSerializer implements ISerializer
	{
		public function serialize(obj : Object) : *
		{
			return JSON.stringify(obj);
		}

		public function deserialize(obj : *) : Object {
			return JSON.parse( obj );
		}

		public function get name() : String {
			return "json";
		}
	}
}
