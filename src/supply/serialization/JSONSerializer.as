package supply.serialization {
	import supply.api.ISerializer;
	import supply.api.IModel;
	/**
	 * @author jamieowen
	 */
	public class JSONSerializer implements ISerializer
	{
		public function JSONSerializer()
		{
			
		}
		
		public function serialize(model:IModel):*
		{
			return null;
		}
		
		public function serializeMany( models:Vector.<IModel>):*
		{
			return null;
		}
		
		public function deserialize(data:*):IModel
		{
			return null;
		}
		
		public function deserializeMany( data:* ):Vector.<IModel>
		{
			return null;
		}
	}
}
