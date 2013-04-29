package supply.fields {
	import flash.utils.getQualifiedClassName;
	import supply.Supply;
	import supply.api.IModel;
	import supply.api.IModelField;
	
	import supply.core.ns.supply_internal;
	
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
			var field:IModelField = Supply().fieldsManager.getFieldForType(vectorType);
			if( field ){
				return true;
			}else{
				return false;	
			}
		}

		public function toObject(value:*, type:String) : *
		{
			var type:String = getQualifiedClassName(value);
			var vectorType:String = getVectorTypeString(type);
			
			var handler:IModelField = Supply().fieldsManager.getFieldForType(vectorType);
			
			if( handler )
			{
				var serialized:Array = [];
				var item:*;
				var i:int;
				for( i = 0; i<value.length; i++ ){
					item = value[i];
					serialized.push( handler.toObject(item) );
				}
				return serialized; 	
			}else{
				Supply().warn("An objects type found in a Vector when serializing is not supported. Type : " + type );
				return null;
			}
		}

		public function fromObject(value:*, type:String) : *
		{
			if( value is Array ){
				var i:int;
				var item:*;
				var a:Array = value as Array;
				var c:Class;
				var deserialized:Vector.<*> = new Vector.<*>();
				
				for( i = 0; i<a.length; i++ )
				{
					item = a[i];
					deserialized.push( item );					
				}
				
				return deserialized; 
			}else{
				return null;
			}
		}
	}
}
