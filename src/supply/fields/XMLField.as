package supply.fields {
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

		public function toObject(value:*, type:String) : *
		{
			var xml:XML = value as XML;
			if( xml ){
				return xml.toString();	
			}else{
				return null;
			}
		}

		public function fromObject(value:*, type:String) : *
		{
			if( value is String ){
				return new XML(value);
			}else{
				return null;
			}
		}
	}
}
