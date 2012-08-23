package tests.serialization {
	import mock.models.Album;
	import mock.models.Tag;
	import mock.models.Photographer;
	import mock.models.Photo;

	import supply.core.ModelManager;
	import supply.core.SupplyContext;
	/**
	 * @author jamieowen
	 */
	public class ObjectSerializerTest
	{
		public function createPhoto():Photo
		{
			var photo:Photo = new Photo();
			photo.title = "Jamie";
			photo.focalRatio = 1.4;
			photo.lens = 35;
			photo.published = new Date();
			//photo.tags =
			//photo.author
			
			return photo;			
		}
		
		[Test]
		public function test_object_serialize_Photo():void
		{
			var context:SupplyContext = new SupplyContext();
			context.register(Photo,Photographer,Tag,Album);
			var manager:ModelManager = context.objects(Photo) as ModelManager;
			var photo:Photo = createPhoto();
			trace( "Serialize" );
			trace( manager.serializer.serialize(photo) );
			
			
			
		}
		
	}
}
