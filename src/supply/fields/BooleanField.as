package supply.fields {
	import supply.api.IModel;
	import supply.api.IModelField;

	/**
	 * @author jamieowen
	 */
	public class BooleanField implements IModelField
	{
		public function handlesType(type:String) : Boolean
		{
			return type == "Boolean";
		}

		public function toObject(value:*, type:String) : *
		{
			if( value is Boolean ){
				return value;	
			}else{
				return null;
			}
		}

		public function fromObject(value:*, type:String) : *
		{
			if( value is Boolean ){
				return value;
			}else{
				return null;
			}
		}
	}
}
