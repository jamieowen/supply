package supply.fields {
	import supply.api.IModel;
	import supply.api.IModelField;

	/**
	 * @author jamieowen
	 */
	public class intField implements IModelField
	{
		public function getType() : String
		{
			return "int";
		}

		public function toObject(model:IModel,fieldName:String) : *
		{
			return model[fieldName];
		}

		public function fromObject(obj:Object,model:IModel,fieldName:String) : void
		{
			model[fieldName] = obj;
		}
	}
}
