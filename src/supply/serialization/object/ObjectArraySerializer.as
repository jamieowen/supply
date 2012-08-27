package supply.serialization.object {
	import flash.utils.getQualifiedClassName;
	import supply.serialization.IPropertySerializer;
	import supply.serialization.ISerializerData;
	import supply.api.IModel;
	import supply.core.reflect.ReflectedProperty;

	/**
	 * @author jamieowen
	 */
	public class ObjectArraySerializer implements IPropertySerializer
	{
		
		public function ObjectArraySerializer()
		{
			
		}
		
		public function handlesProperty(property : ReflectedProperty) : Boolean
		{
			return property.type == getQualifiedClassName(Array);
		}

		public function serialize(property : ReflectedProperty, data : ISerializerData, instance : IModel) : *
		{
			var array:Array = instance[property.name] as Array;
			if( array ){
				var item:*;
				var arrayIsGood:Boolean = true;
				for( var i:int = 0; i<array.length; i++ ){
					item = array[i];
					// only support primitive types within an array.
					if( !(item is int) && 
						!(item is uint) &&
						!(item is Number) && 
						!(item is String) && 
						!(item is Boolean) )
					{
						arrayIsGood = false;
					}
				}
				if( arrayIsGood)
					data.data[property.name] = array.slice(0);
				else
					trace( "Array contained unsupported types" );
			}else{
				// don't store.
				//data.data[property.name] = "";
			}			
		}

		public function deserialize(property : ReflectedProperty, data : ISerializerData, into : IModel) : void
		{
			var from:Object = data.data as Object;
			if( from.hasOwnProperty(property.name) ){
				if( from[property.name] is Array ){
					into[property.name] = (from[property.name] as Array).slice(0);
				}
			}			
		}
	}
}
