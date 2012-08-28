package tests.serialization {
	import supply.storage.request.Request;
	import org.hamcrest.date.dateEqual;
	import supply.serialization.ObjectSerializer;
	import mock.models.Album;
	import mock.models.Photo;
	import mock.models.Photographer;
	import mock.models.Tag;

	import supply.core.ModelManager;
	import supply.core.SupplyContext;
	import supply.core.uuid;

	import org.hamcrest.assertThat;
	import org.hamcrest.core.allOf;
	import org.hamcrest.object.hasPropertyWithValue;
	/**
	 * @author jamieowen
	 */
	public class ObjectSerializerTest
	{
		public function createPhoto():Photo
		{
			var photo:Photo = new Photo();
			photo.title = "Cloudy Sky";
			photo.focalRatio = 1.4;
			photo.lens = 35;
			photo.id = uuid();
			photo.published = new Date(2000,10,10);
			//photo.tags =
			photo.author = createPhotographer();
			
			return photo;
		}
		
		public function createPhotographer():Photographer
		{
			var photographer:Photographer = new Photographer();
			photographer.firstName = "Jamie";
			photographer.lastName = "Owen";
			photographer.email = "name@domainname.com";
			photographer.dob = new Date(1982,2,3);
			photographer.isAmateur = true;
			photographer.id = uuid();
			// array test.
			photographer.customLabels = [10,"Test",false,3.14,-24];
			
			return photographer;
		}
		
		[Test]
		public function test_object_serialize_Photo():void
		{
			const context:SupplyContext = new SupplyContext();
			context.register(Photo,Photographer,Tag,Album);
			const photo:Photo = createPhoto();
			const manager:ModelManager = context.objects(Photo) as ModelManager;
			
			const serializer:ObjectSerializer = new ObjectSerializer();
			manager.info.injector.injectInto(serializer);	
				
			const result:Object = serializer.serialize(photo);
			
			assertThat( result,
				allOf( 
					hasPropertyWithValue("title", "Cloudy Sky"),
					hasPropertyWithValue("focalRatio", 1.4),
					hasPropertyWithValue("lens", 35),
					hasPropertyWithValue("author", photo.author.id ),
					hasPropertyWithValue("published", photo.published.toUTCString() ),
					hasPropertyWithValue("id", photo.id )
					));
		}

		[Test]
		public function test_object_serialize_Photographer():void
		{
			const context:SupplyContext = new SupplyContext();
			context.register(Photo,Photographer,Tag,Album);
			const photographer:Photographer = createPhotographer();
			const manager:ModelManager = context.objects(Photographer) as ModelManager;
			
			const serializer:ObjectSerializer = new ObjectSerializer();
			manager.info.injector.injectInto(serializer);
			
			const result:Object = serializer.serialize(photographer);
			
			assertThat( result,
				allOf( 
					hasPropertyWithValue("firstName", "Jamie"),
					hasPropertyWithValue("lastName", "Owen"),
					hasPropertyWithValue("email", "name@domainname.com"),
					hasPropertyWithValue("dob", photographer.dob.toUTCString() ),
					hasPropertyWithValue("isAmateur", true ),
					hasPropertyWithValue("id", photographer.id ),
					hasPropertyWithValue("customLabels", photographer.customLabels.slice(0) )
					));
		}
		
		[Test]
		public function test_object_deserialize_Photo():void
		{
			const context:SupplyContext = new SupplyContext();
			context.register(Photo,Photographer,Tag,Album);
			const manager:ModelManager = context.objects(Photo) as ModelManager;
			
			const serializer:ObjectSerializer = new ObjectSerializer();
			manager.info.injector.injectInto(serializer);
			
			var date:Date = new Date( 2000,8,13);
			var photo:Object = {title:"Cloudy Sky", focalRatio:1.4, lens:35, author:uuid(), published:date.toUTCString(), id:uuid() };
			var result:Photo = serializer.deserialize(photo, new Vector.<Request>()) as Photo;
	
			assertThat( result,
				allOf( 
					hasPropertyWithValue("title", "Cloudy Sky"),
					hasPropertyWithValue("focalRatio", 1.4),
					hasPropertyWithValue("lens", 35),
					//hasPropertyWithValue("author", photo.author ),
					hasPropertyWithValue("published", dateEqual(date) ),
					hasPropertyWithValue("id", photo.id )
					));
		}

		[Test]
		public function test_object_deserialize_Photographer():void
		{
			const context:SupplyContext = new SupplyContext();
			context.register(Photo,Photographer,Tag,Album);
			const manager:ModelManager = context.objects(Photographer) as ModelManager;
			
			const serializer:ObjectSerializer = new ObjectSerializer();
			manager.info.injector.injectInto(serializer);
			
			var date:Date = new Date( 2000,8,13);
			var photographer:Object = {firstName:"Jamie", lastName:"Owen", email:"name@domainname.com", dob:date.toUTCString(), isAmateur:true, id:uuid(), customLabels:[1,3,2,4,5] };
			var result:Photographer = serializer.deserialize(photographer, new Vector.<Request>()) as Photographer;
	
			assertThat( result,
				allOf( 
					hasPropertyWithValue("firstName", "Jamie"),
					hasPropertyWithValue("lastName", "Owen"),
					hasPropertyWithValue("email", "name@domainname.com"),
					hasPropertyWithValue("dob", dateEqual(date) ),
					hasPropertyWithValue("isAmateur", true ),
					hasPropertyWithValue("id", photographer.id ),
					hasPropertyWithValue("customLabels", [1,3,2,4,5] )
					));
		}
		
	}
}
