package supply.serialization {
	import supply.api.IModelManager;
	import supply.api.ISerializer;
	import supply.api.IModel;

	/**
	 * @author jamieowen
	 */
	public class ObjectSerializer implements ISerializer
	{
		[Inject]
		public var modelManager:IModelManager;
		
		
		public function serialize(model : IModel) : *
		{
			
		}

		public function serializeMany(models : Vector.<IModel>) : *
		{
			
		}

		public function deserialize(data : *) : IModel
		{
			// TODO: Auto-generated method stub
			return null;
		}

		public function deserializeMany(data : *) : Vector.<IModel>
		{
			// TODO: Auto-generated method stub
			return null;
		}
	}
}
