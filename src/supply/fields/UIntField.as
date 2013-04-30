package supply.fields {
	import supply.api.IModel;
	import supply.api.IModelField;

	/**
	 * @author jamieowen
	 */
	public class uintField implements IModelField
	{
		public function handlesType(type:String) : Boolean
		{
			return type == "uint";
		}

		public function toObject(value:*, type:String) : *
		{
			if( value is uint ){
				return value;	
			}else{
				return null;
			}
		}

		public function fromObject(value:*, type:String) : *
		{
			if( value is uint ){
				return value;
			}else{
				return null;
			}
		}
		
		public function isEqual(obj1:*,obj2:*, type:String):Boolean
		{
			if( obj1 is uint && obj2 is uint ){
				return obj1 == obj2;
			}else
				return false; 
		}
	}
}
