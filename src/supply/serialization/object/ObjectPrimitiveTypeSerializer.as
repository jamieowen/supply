package supply.serialization.object {
	import supply.serialization.ISerializerData;
	import avmplus.getQualifiedClassName;
	import supply.core.reflect.ReflectedProperty;
	import supply.serialization.IPropertySerializer;
	import supply.api.IModel;

	/**
	 * @author jamieowen
	 */
	public class ObjectPrimitiveTypeSerializer implements IPropertySerializer
	{
		
		public function ObjectPrimitiveTypeSerializer()
		{
			
		}
		
		public function handlesProperty( property:ReflectedProperty ):Boolean
		{
			switch( property.type )
			{
				case getQualifiedClassName(int):
					return true;
				case getQualifiedClassName(uint):
					return true;
				case getQualifiedClassName(Boolean):
					return true;
				case getQualifiedClassName(String):
					return true;
				case getQualifiedClassName(Number):
					return true;
				default:
					return false;
			}
		}
		
		public function serialize( property:ReflectedProperty, data:ISerializerData, instance:IModel ):*
		{
			data.data[ property.name ] = instance[ property.name ];
		}
		
		public function deserialize( property:ReflectedProperty, data:ISerializerData, into:IModel ):void
		{
			var from:Object = data.data as Object;
			if( from.hasOwnProperty(property.name) ){
				into[property.name] = from[property.name];
			}
		}
	}
}
