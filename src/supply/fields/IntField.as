package supply.fields {
	import supply.api.IModel;
	import supply.api.IModelField;

	/**
	 * @author jamieowen
	 */
	public class intField implements IModelField
	{
		public function handlesType(type:String) : Boolean
		{
			return type == "int";
		}

		public function toObject(value:*, type:String) : *
		{
			if( value is int ){
				return value;	
			}else{
				return null;
			}
		}

		public function fromObject(value:*, type:String) : *
		{
			if( value is int ){
				return value;
			}else{
				return null;
			}
		}
	}
}
