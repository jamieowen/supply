package tests.core {
	import mock.models.Album;
	import mock.models.Photo;
	import mock.models.Photographer;
	import mock.models.Tag;

	import supply.api.IModel;
	import supply.core.Supply;
	import supply.core.SupplyRegister;
	import supply.core.SupplyUnregister;
	import supply.queries.QuerySet;

	import org.flexunit.asserts.assertEquals;
	/**
	 * @author jamieowen
	 */
	public class BasicSupplyTest
	{
		[Test(order=1)]
		public function test_register():void
		{
			SupplyRegister(Photo,Photographer,Tag,Album);
		}
		
		[Test(order=2)]
		public function test_createModels():void
		{
			var photographer:Photographer = new Photographer();
			photographer.firstName = "Horst";
			photographer.lastName = "Hamann";
			photographer.email = "horst@hamann.com";
			photographer.isAmateur = false;
			photographer.dob = new Date(1958,4,27);
			photographer.customLabels = ["Test", "Test2", 1,2,3 ];
			
			var photo:Photo = new Photo();
			photo.title = "New York";
			photo.published = new Date(2001,1,1);
			photo.focalRatio = 1.4;
			photo.lens = 35;
			photo.author = photographer;
			
			Supply(Photographer).create( photographer );
			Supply(Photo).create( photo );
			
			var photographers:QuerySet 	= Supply(Photographer).query.all();
			var photos:QuerySet  		= Supply(Photo).query.all();
			
			assertEquals( 1, photographers.items.length );
			assertEquals( 1, photos.items.length );
			
		}

		[Test(order=3)]
		public function test_queryModels():void
		{
			var photographers:QuerySet = Supply(Photographer).query.all();
			var photos:QuerySet  = Supply(Photo).query.all();
			
			assertEquals( 1, photographers.items.length );
			assertEquals( 1, photos.items.length );
			
		}

		[Test(order=4)]
		public function test_updateModels():void
		{
			var photographers:Vector.<IModel> 	= Supply(Photographer).query.filter( "firstName").values("Horst").all().items;
			var photos:Vector.<IModel> 			= Supply(Photo).query.filter( "title").values("New York").all().items;
			
			trace( photographers[0] );
			var photographer:Photographer = photographers[0] as Photographer;
			var photo:Photo = photos[0] as Photo;
			
			photographer.firstName = "Ansel";
			photographer.lastName = "Adams";
			photographer.email = "ansel@adams.com";
			
			photo.title = "Lake";
			
			Supply(Photographer).update(photographer);
			Supply(Photo).update( photo );
			
			photographers 	= Supply(Photographer).query.filter( "firstName").values("Ansel").all().items;
			photos			= Supply(Photo).query.filter( "title").values("Lake").all().items;
			
			trace( photographers[0] );
			
			assertEquals( 1, photographers.length );
			assertEquals( 1, photos.length );			
		}
		
		[Test(order=5)]
		public function test_destroyModels():void
		{
			var photographers:QuerySet 	= Supply(Photographer).query.all();
			var photos:QuerySet  		= Supply(Photo).query.all();
			
			for each( var photo:Photo in photos.items ){
				Supply(Photo).destroy(photo);
			}

			for each( var photographer:Photographer in photographers.items ){
				Supply(Photographer).destroy(photographer);
			}
			
			photographers 	= Supply(Photographer).query.all();
			photos  		= Supply(Photo).query.all();
			
			assertEquals( 0, photographers.items.length );
			assertEquals( 0, photos.items.length );
		}
		
		[Test(order=500)]
		public function test_unregister():void
		{
			SupplyUnregister(Photo,Photographer,Tag,Album);
		}
	}
	

}
