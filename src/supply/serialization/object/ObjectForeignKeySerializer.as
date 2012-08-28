package supply.serialization.object {
	import supply.storage.request.Request;
	import supply.errors.SerializationError;
	import supply.core.modelHasId;
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
			var foreignModel:IModel = instance[property.name] as IModel;
			if( foreignModel == null ){
				data.data[property.name] = "";
			}else
			if( modelHasId(foreignModel) ){
				data.data[property.name] = foreignModel.id;
			}else{
				throw new SerializationError( "Foreign Model has no ID set.  Save the Foreign Model before this." );
			}
		}

		public function deserialize(property : ReflectedProperty, data : ISerializerData, into : IModel, subRequests:Vector.<Request> ) : void
		{
			
		}
	}
}
