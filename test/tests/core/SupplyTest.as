package tests.core
{
	import supply.core.SupplyRegister;
	import supply.core.Supply;
	import mock.models.Tag;
	import mock.models.Photographer;
	import mock.models.Album;
	import mock.models.Photo;
	import supply.core.SupplyContext;
	/**
	 * @author jamieowen
	 */
	public class SupplyTest
	{
		[BeforeClass]
		public static function setup():void
		{
			SupplyRegister(Photo,Album,Photographer,Tag);
			
			//Supply(Photo).filter("id").values(1,2)
			
			
			var author:Photographer = new Photographer();
			author.save();
			
			var photo:Photo = new Photo();
			photo.author = author;
			photo.save();
			
			
			
			//Supply().register(Photo,Album,Photographer,Tag);
			//Supply( Photo ).query("firstName", "lastName").equals( "Jamie", "Owen" ).all(); // returns with a typed vector or an async token - or a signal?
			//Supply( Album ).all()
			
			// QuerySet  |  Match  |  QuerySet  |  Match  |  QuerySet  |  
			
			// QuerySet.query() : Match
			// QuerySet.all() : *
			// QuerySet.first(10) : *
			// QuerySet.last(10) : *
			// QuerySet.chunk( 10, 50 )
			// QuerySet.sort( ) : *
			
			// Match.equals()
			// 
			
			
			// How do we differentiate between querying on a local set or a remote set?
			// E.g. with A locally stored model we are always querying on all the models and pulling directly from disc.
			// But with remote queries we want to make a query, then be able to query just that result set without sending a request
			// to the server each time. How do we make this easy and intuitive?
			
			// Supply(   *   )
			
			photo.tags.all();	
			
		}
		
		[AfterClass]
		public static function teardown():void
		{
			
		}
	}
	

}
