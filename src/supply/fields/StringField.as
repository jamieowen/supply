package supply.fields {
	import supply.api.IModel;
	import supply.api.IModelField;

	/**
	 * @author jamieowen
	 */
	public class StringField implements IModelField
	{
		public function handlesType(type:String) : Boolean
		{
			return type == "String";
		}

		public function toObject(value:*, type:String) : *
		{
			if( value is String ){
				return value;	
			}else{
				return null;
			}
		}

		public function fromObject(value:*, type:String) : *
		{
			if( value is String ){
				return value;
			}else{
				return null;
			}
		}
		
		public function isEqual(obj1:*,obj2:*, type:String):Boolean
		{
			if( obj1 is String && obj2 is String ){
				return obj1 == obj2;
			}else
				return false; 
		}
	}
}
