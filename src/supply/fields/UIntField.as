package supply.fields {
	import supply.api.IModel;
	import supply.api.IModelField;

	/**
	 * @author jamieowen
	 */
	public class uintField implements IModelField
	{
		public function getType() : String
		{
			return "uint";
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
