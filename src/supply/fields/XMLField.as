package supply.fields {
	import supply.api.IModel;
	import supply.api.IModelField;

	/**
	 * @author jamieowen
	 */
	public class XMLField implements IModelField
	{
		public function handlesType(type:String) : Boolean
		{
			return type == "XML";
		}

		public function toObject(model:IModel,fieldName:String) : *
		{
			return ( model[fieldName] as XML ).toString();
		}

		public function fromObject(obj:Object,model:IModel,fieldName:String) : void
		{
			model[fieldName] = new XML(obj);
		}
	}
}
