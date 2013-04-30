package supply.fields {
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
		
		public function isEqual(obj1:*,obj2:*, type:String):Boolean
		{
			if( obj1 is Number && obj2 is Number ){
				return obj1 == obj2;
			}else
				return false; 
		}
	}
}
