package supply.fields {
	import supply.api.IModel;
	import supply.api.IModelField;

	/**
	 * @author jamieowen
	 */
	public class DateField implements IModelField
	{
		public function getType() : String
		{
			return "Date";
		}

		public function toObject(model:IModel,fieldName:String) : *
		{
			return ( model[fieldName] as Date ).getTime();
		}

		public function fromObject(obj:Object,model:IModel,fieldName:String) : void
		{
			model[fieldName] = new Date(obj);
		}
	}
}
