package supply.fields {
	import supply.Supply;
	import flash.utils.getQualifiedClassName;
	import supply.api.IModel;
	import supply.api.IModelField;
	
	import supply.core.ns.supply_internal;
	
	use namespace supply_internal;

	/**
	 * @author jamieowen
	 */
	public class ArrayField implements IModelField
	{
		public function handlesType(type:String) : Boolean
		{
			return type == "Array";
		}

		public function toObject(value:*, type:String) : *
		{
			var array:Array = value as Array;
			var item:*;
			var i:int;
			var arrayItemType:String;
			var handler:IModelField;
			var serialized:Array = [];
			for( i = 0; i<array.length; i++ ){
				item = array[i];
				arrayItemType = getQualifiedClassName(item);
				handler = Supply().fieldsManager.getFieldForType(arrayItemType);
				if( handler ){
					serialized.push( handler.toObject(array[i], arrayItemType) );
				}else{
					Supply().warn("An objects type found in an Array when serializing is not supported. Type : " + type );
					return serialized.push( null );
				}
			}
			return serialized;
		}

		public function fromObject(value:*, type:String) : *
		{
			if( value is Array ){
				return value;
			}else{
				return null;
			}
		}
	}
}
