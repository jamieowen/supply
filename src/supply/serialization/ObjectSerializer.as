package supply.serialization {
	import supply.serialization.object.ObjectForeignKeySerializer;
	import supply.serialization.object.ObjectSerializerData;
	import flash.utils.Dictionary;
	import avmplus.getQualifiedClassName;
	import supply.api.IModel;
	import supply.api.IModelManager;
	import supply.api.ISerializer;
	import supply.core.reflect.ReflectedModel;
	import supply.core.reflect.ReflectedProperty;
	import supply.serialization.object.ObjectPrimitiveTypeSerializer;

	/**
	 * @author jamieowen
	 */
	public class ObjectSerializer implements ISerializer
	{
		[Inject]
		public var modelManager:IModelManager;
		
		[Inject]
		public var reflect:ReflectedModel;
		
		private var _serializers:Vector.<IPropertySerializer>;
		
		public function ObjectSerializer()
		{
			super();
			
			_serializers = new Vector.<IPropertySerializer>();
			_serializers.push( new ObjectPrimitiveTypeSerializer() );
			_serializers.push( new ObjectForeignKeySerializer() );
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
				
				if( typeSerializer ){
					trace( "Handled : " + property.type );
					typeSerializer.serialize(property, data, model );
				}else{
					trace( "Unhandled type.." + property.type );
				}
			}
			
			trace( data );
		}

		public function serializeMany(models : Vector.<IModel>) : *
		{
			var result:*;
			var previous:* = result;
			var next:*;
			for each( var model:IModel in models ){
				serialize(model);
			}			
		}

		public function deserialize(data : *) : IModel
		{
			return null;
		}

		public function deserializeMany(data : *) : Vector.<IModel>
		{
			// TODO: Auto-generated method stub
			return null;
		}
	}
}
