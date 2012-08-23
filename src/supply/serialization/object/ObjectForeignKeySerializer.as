package supply.serialization.object {
	import supply.serialization.IPropertySerializer;
	import supply.serialization.ISerializerData;
	import supply.api.IModel;
	import supply.core.reflect.ReflectedProperty;

	/**
	 * @author jamieowen
	 */
	public class ObjectForeignKeySerializer implements IPropertySerializer
	{
		public function handlesProperty(property : ReflectedProperty) : Boolean
		{
			return property.isForeignKey;
		}

		public function serialize(property : ReflectedProperty, data : ISerializerData, instance : IModel) : *
		{
			
		}

		public function deserialize(property : ReflectedProperty, data : ISerializerData, into : IModel) : void
		{
			
		}
	}
}
