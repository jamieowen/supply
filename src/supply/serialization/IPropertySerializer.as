package supply.serialization {
	import supply.storage.request.Request;
	import supply.core.reflect.ReflectedProperty;
	import supply.api.IModel;
	/**
	 * @author jamieowen
	 */
	public interface IPropertySerializer
	{
		function handlesProperty( property:ReflectedProperty ):Boolean;
		function serialize( property:ReflectedProperty, data:ISerializerData, instance:IModel ):*;
		function deserialize( property:ReflectedProperty, data:ISerializerData, into:IModel, subRequests:Vector.<Request> ):void;
	}
}
