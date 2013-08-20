package supply.fields {
	import supply.Supply;
	import supply.api.IModelField;
	import supply.core.ns.supply_internal;

	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	use namespace supply_internal;
	
	/**
	 * @author jamieowen
	 */
	public class VectorField implements IModelField
	{
		private static function getVectorTypeString(type:String):String
		{
			if( type.indexOf( "__AS3__.vec::Vector.<" ) == 0 ){
				return type.replace( "__AS3__.vec::Vector.<", "" ).replace(">", "" );
			}else{
				return null;	
			}
		}
		
		public function handlesType(type:String) : Boolean
		{
			var vectorType:String = getVectorTypeString(type);
			var field:IModelField = Supply.fieldsManager.getFieldForType(vectorType);
			if( field ){
				return true;
			}else{
				return false;
			}
		}

		public function toObject(value:*, type:String) : *
		{
			var vectorType:String = getVectorTypeString(type);
			var handler:IModelField = Supply.fieldsManager.getFieldForType(vectorType);
			
			if( handler )
			{
				if( value == null ){
					return null;
				}
				var serialized:Array = [];
				var item:*;
				var i:int;
				for( i = 0; i<value.length; i++ ){
					item = value[i];
					serialized.push( handler.toObject(item, type) );
				}
				return serialized; 	
			}else{
				Supply.warn("An objects type found in a Vector when serializing is not supported. Type : " + type );
				return null;
			}
		}

		public function fromObject(value:*, type:String) : *
		{
			var vectorType:String = getVectorTypeString(type);
			var handler:IModelField = Supply.fieldsManager.getFieldForType(vectorType);
			
			// Vectors are saved as arrays, but we can cast to the correct
			// type by using the Vectors Field handler.
			if( value is Array ){
				var i:int;
				var item:*;
				var a:Array = value as Array;
				var c:Class;
				// create a vector of the type specified by type.
				var vectorClass:Class = getDefinitionByName( type ) as Class;
				var deserializedVector:* = new vectorClass();
				
				for( i = 0; i<a.length; i++ )
				{
					item = a[i];
					deserializedVector.push( handler.fromObject(item, getQualifiedClassName(item) ) );					
				}
				
				return deserializedVector;
			}else{
				return null;
			}
		}
		
		public function isEqual(obj1:*,obj2:*, type:String):Boolean
		{
			if( obj1 is Array && obj2 is Array ){
				var vectorType:String = getVectorTypeString(type);
				var handler:IModelField = Supply.fieldsManager.getFieldForType(vectorType);
							
				var a1:Array = obj1;
				var a2:Array = obj2;
				
				var equal:Boolean = a1.length == a2.length;
				
				for( var i:int = 0; i<a1.length && equal; i++ )
				{
					equal = equal && handler.isEqual(a1[i], a2[i],vectorType);
				}
				
				return equal;
			}else
				return false;
		}		
	}
}
