package tests.models {
	import avmplus.getQualifiedClassName;
	import mock.models.Album;
	import mock.models.Photo;
	import mock.models.Photographer;
	import mock.models.ReflectAllModel;
	import mock.models.Tag;
	import org.flexunit.asserts.assertEquals;
	import org.hamcrest.Matcher;
	import org.hamcrest.assertThat;
	import org.hamcrest.collection.hasItem;
	import org.hamcrest.core.allOf;
	import org.hamcrest.core.anyOf;
	import org.hamcrest.core.throws;
	import org.hamcrest.object.hasPropertyWithValue;
	import org.osflash.signals.ISignal;
	import supply.api.IModel;
	import supply.core.reflect.ReflectedProperty;
	import supply.core.reflect.reflectPropertiesFromModelClass;
	import supply.core.reflect.reflectPropertiesFromModelInstance;
	import supply.errors.ReflectionError;



	/**
	 * @author jamieowen
	 */
	public class ReflectTest
	{
		public function getIModelProps():Array
		{
			// name, store, readonly, type
			var props:Array = [
				"onSave", 		false, 	true, 	getQualifiedClassName(ISignal),
				"onDestroy", 	false, 	true, 	getQualifiedClassName(ISignal),
				"onUpdate", 	false, 	true, 	getQualifiedClassName(ISignal)
				];

			return props;
		}
		
		public function assertModel(model:IModel, expected_props:Array ):void
		{
			expected_props = expected_props.concat.apply( this, getIModelProps() );
			
			var properties:Vector.<ReflectedProperty> = reflectPropertiesFromModelInstance(model);
			
			var matchers:Array = [];
			var exists_matchers:Array = [];
			var matcher:Matcher;
			
			for( var i:int = 0; i<expected_props.length; i+=4 )
			{
				matchers.push( 
					allOf( 
						hasPropertyWithValue("name", 		expected_props[i]),
						hasPropertyWithValue("store", 		expected_props[i+1]),
						hasPropertyWithValue("readonly", 	expected_props[i+2]),
						hasPropertyWithValue("type", 		expected_props[i+3])
						));
				
				exists_matchers.push( hasPropertyWithValue("name", expected_props[i]) );
			}
			
			// assert all properties exist.
			for each( matcher in exists_matchers ){
				assertThat( "A property does not exist on IModel :'" + getQualifiedClassName(model) + "'", properties, hasItem( matcher ) );
			}
			
			// assert all properties are correct
			for each( var prop:ReflectedProperty in properties ){
				assertThat( prop, anyOf( matchers ) );
			}
			
			// assert total properties.
			assertEquals( "Number of expected properties does not match.", exists_matchers.length, properties.length );
		}
		
		[Test]
		public function test_album_Reflect():void
		{
			var model:Album = new Album();
			
			// name, store, readonly, type
			var props:Array = [
				"name", 		true, 	false, 	getQualifiedClassName(String),
				"author", 		true, 	false, 	getQualifiedClassName(Photographer),
				"photos", 		true, 	false, 	getQualifiedClassName( new Vector.<Photo>() )
				];
			
			assertModel(model, props);			
		}

		[Test]
		public function test_photo_Reflect():void
		{
			
			var model:Photo = new Photo();
			
			// name, store, readonly, type
			var props:Array = [
				"title", 		true, 	false, 	getQualifiedClassName(String),
				"author", 		true, 	false, 	getQualifiedClassName(Photographer),
				"tags", 		true, 	false, 	getQualifiedClassName( new Vector.<Tag>() ),
				"published",	true, 	false, 	getQualifiedClassName(Date),
				"lens",			true, 	false, 	getQualifiedClassName(int),
				"focalRatio",	true, 	false, 	getQualifiedClassName(Number)
				];
			
			assertModel(model, props);
		}
		
		[Test]
		public function test_photographer_Reflect():void
		{
			var model:Photographer = new Photographer();

			// name, store, readonly, type
			var props:Array = [
				"firstName", 		true, 	false, 	getQualifiedClassName(String),
				"lastName", 		true, 	false, 	getQualifiedClassName(String),
				"email", 			true, 	false, 	getQualifiedClassName(String),
				"dob",				true, 	false, 	getQualifiedClassName(Date),
				"isAmateur",		true, 	false, 	getQualifiedClassName(Boolean)
				];
			
			assertModel(model, props);				
		}
		
		[Test]
		public function test_tag_Reflect():void
		{
			var model:Tag = new Tag();

			// name, store, readonly, type
			var props:Array = [
				"name", 		true, 	false, 	getQualifiedClassName(String)
				];
			
			assertModel(model, props);
		}
		
		[Test]
		public function test_reflectAll_Reflect():void
		{
			var model:ReflectAllModel = new ReflectAllModel();
			
			// name, store, readonly, type
			var props:Array = [
				"string_property", 				true, 	false, 	getQualifiedClassName(String),
				"number_property", 				true, 	false, 	getQualifiedClassName(Number),
				"int_property", 				true, 	false, 	getQualifiedClassName(int),
				"uint_property",				true, 	false, 	getQualifiedClassName(uint),
				"date_property",				true, 	false, 	getQualifiedClassName(Date),
				"object_property",				true, 	false, 	getQualifiedClassName(Object),
				"array_property",				true, 	false, 	getQualifiedClassName(Array),
				"model_vector",					true, 	false, 	getQualifiedClassName(new Vector.<ReflectAllModel>()),
				"nostore_string_property", 		false, 	false, 	getQualifiedClassName(String),
				"readwrite_string_property", 	true, 	false, 	getQualifiedClassName(String),
				"readonly_string_property", 	true, 	true, 	getQualifiedClassName(String)
				];
			
			assertModel(model, props);
		}
		
		[Test]
		public function test_noneModel_Reflect():void
		{
			var reflect:Function = function():void{
				 reflectPropertiesFromModelClass(Date);
			};
			
			assertThat( reflect, throws(ReflectionError) );
		}
	
	}
}
