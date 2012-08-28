package supply.serialization.object {
	import supply.storage.request.Request;
	import flash.utils.getQualifiedClassName;
	import supply.serialization.IPropertySerializer;
	import supply.core.reflect.ReflectedProperty;
	import supply.api.IModel;
	import supply.serialization.ISerializerData;

	/**
	 * @author jamieowen
	 */
	public class ObjectDateSerializer implements IPropertySerializer
	{
		
		public function ObjectDateSerializer()
		{
			
		}
		
		public function handlesProperty(property : ReflectedProperty) : Boolean
		{
			return property.type == getQualifiedClassName(Date);
		}

		public function serialize(property : ReflectedProperty, data : ISerializerData, instance : IModel) : *
		{
			var date:Date = instance[property.name] as Date;
			if( date ){
				data.data[property.name] = date.toUTCString();
			}else{
				// don't store.
				//data.data[property.name] = "";
			}
		}

		public function deserialize(property : ReflectedProperty, data : ISerializerData, into : IModel, subRequests:Vector.<Request> ) : void
		{
			var from:Object = data.data as Object;
			if( from.hasOwnProperty(property.name) ){
				into[property.name] = new Date( from[property.name] );
			}
		}
	}
}
