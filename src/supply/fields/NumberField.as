package supply.fields {
	import supply.api.IModel;
	import supply.api.IModelField;

	/**
	 * @author jamieowen
	 */
	public class NumberField implements IModelField
	{
		public function handlesType(type:String) : Boolean
		{
			return type == "Number";
		}

		public function toObject(value:*, type:String) : *
		{
			if( value is Number ){
				return value;	
			}else{
				return null;
			}
		}

		public function fromObject(value:*, type:String) : *
		{
			if( value is Number ){
				return value;
			}else{
				return null;
			}
		}
	}
}
