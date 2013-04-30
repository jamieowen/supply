package supply.fields {
	import supply.Supply;
	import supply.api.IModelField;
	import supply.core.ns.supply_internal;

	import flash.utils.getQualifiedClassName;
	
	use namespace supply_internal;

	/**
	 * The ArrayField handles serialization and derseialization of
	 * an Array typed property on a Model class.
	 * Because Array's are untyped in comparison to the Vector class.
	 * When an Array is serialized it must also store the objects type
	 * along with it's value so it can deserialize the field correctly.
	 * This can add some extra storage overhead so it is recommended
	 * that a typed vector is used instead.
	 * 
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
			
			if( array ){
				var item:*;
				var i:int;
				var arrayItemType:String;
				var handler:IModelField;
				var serialized:Array = [];
				var serializedObj:Object;
				for( i = 0; i<array.length; i++ ){
					item = array[i];
					arrayItemType = getQualifiedClassName(item);
					handler = Supply().fieldsManager.getFieldForType(arrayItemType);
					if( handler ){
						serializedObj = {type:arrayItemType, value:handler.toObject(array[i], arrayItemType)};
						serialized.push( serializedObj );
					}else{
						Supply().warn("An objects type found in an Array when serializing is not supported. Type : " + type );
						return serialized.push( null );
					}
				}
				return serialized;
			}else{
				return null;
			}
		}

		public function fromObject(value:*, type:String) : *
		{
			var array:Array = value as Array;
			if( array ){
				var item:Object;
				var results:Array = [];
				var handler:IModelField;
				for( var i:int = 0; i<array.length;i++ )
				{
					item = array[i];
					handler = Supply().fieldsManager.getFieldForType(item.type);
					results.push( handler.fromObject(item.value, item.type) );	
				}
				return results;
			}else{
				return null;
			}
		}
		
		public function isEqual(obj1:*,obj2:*, type:String):Boolean
		{
			if( obj1 is Array && obj2 is Array ){
				var a1:Array = obj1;
				var a2:Array = obj2;
				
				var handler:IModelField;
				var equal:Boolean = a1.length == a2.length;
				var itemType:String;
				for( var i:int = 0; i<a1.length && equal; i++ )
				{
					itemType = a1[i]["type"];
					handler = Supply().fieldsManager.getFieldForType(itemType);
					equal = equal && handler.isEqual(a1[i], a2[i], itemType );
				}
				
				return equal;
			}else
				return false;
		}		
	}
}
