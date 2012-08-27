package supply.serialization {
	import supply.core.ContextModelData;
	import supply.serialization.object.ObjectArraySerializer;
	import supply.serialization.object.ObjectDateSerializer;
	import supply.api.IModel;
	import supply.api.IModelManager;
	import supply.api.ISerializer;
	import supply.core.reflect.ReflectedModel;
	import supply.core.reflect.ReflectedProperty;
	import supply.serialization.object.ObjectForeignKeySerializer;
	import supply.serialization.object.ObjectPrimitiveTypeSerializer;
	import supply.serialization.object.ObjectSerializerData;

	/**
	 * @author jamieowen
	 */
	public class ObjectSerializer implements ISerializer
	{
		[Inject]
		public var modelManager:IModelManager;
		
		[Inject]
		public var reflect:ReflectedModel;
		
		[Inject]
		public var info:ContextModelData;
		
		private var _serializers:Vector.<IPropertySerializer>;
		
		public function ObjectSerializer()
		{
			super();
			
			_serializers = new Vector.<IPropertySerializer>();
			
			_serializers.push( new ObjectPrimitiveTypeSerializer() );
			_serializers.push( new ObjectForeignKeySerializer() );
			_serializers.push( new ObjectDateSerializer() );
			_serializers.push( new ObjectArraySerializer() );
		}
		
		public function serialize(model : IModel) : *
		{
			var data:ISerializerData = new ObjectSerializerData();
			var typeSerializer:IPropertySerializer;
			var i:int;
			for each( var property:ReflectedProperty in reflect.properties )
			{
				for( i = 0; i<_serializers.length; i++ )
				{
					typeSerializer = _serializers[i];
					if( typeSerializer.handlesProperty(property))
						break;
					else
						typeSerializer = null;
				}
				
				if( typeSerializer )
					typeSerializer.serialize(property, data, model );
				else{
					//trace( "Unhandled type.." + property.type );
				}
			}
			
			return data.data;
		}

		public function serializeMany(models : Vector.<IModel>) : *
		{
			var items:Array = [];

			for each( var model:IModel in models ){
				items.push( serialize(model) );
			}
			
			return items;
		}

		public function deserialize(data : *) : IModel
		{
			var fromData:ISerializerData = new ObjectSerializerData(data);
			var typeSerializer:IPropertySerializer;
			var i:int;
			var model:IModel = new info.model();
			
			for each( var property:ReflectedProperty in reflect.properties )
			{
				for( i = 0; i<_serializers.length; i++ )
				{
					typeSerializer = _serializers[i];
					if( typeSerializer.handlesProperty(property))
						break;
					else
						typeSerializer = null;
				}
				
				if( typeSerializer )
					typeSerializer.deserialize(property, fromData, model );
				else{
					//trace( "Cannot deserialize type.." + property.type );
				}
			}
			
			return model;
		}
		
		/**
		 * @param data An array of objects. Each object should be serialized IModel instance in a format produced voi
		 */
		public function deserializeMany(data : *) : Vector.<IModel>
		{
			var items:Vector.<IModel> = new Vector.<IModel>();

			for each( var model:Object in data ){
				items.push( deserialize(model) );
			}
			
			return items;
		}
	}
}
