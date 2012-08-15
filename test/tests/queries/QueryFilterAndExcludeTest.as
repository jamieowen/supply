package tests.queries {
	import mock.models.Photo;
	import mock.models.Photographer;
	import mock.storage.QueryTestStorage;

	import supply.api.IModel;
	import supply.core.supply_internals;
	import supply.queries.Query;
	import supply.queries.QueryOptions;
	import supply.queries.matchers.IMatcher;

	import org.hamcrest.Matcher;
	import org.hamcrest.assertThat;
	import org.hamcrest.collection.arrayWithSize;
	import org.hamcrest.collection.everyItem;
	import org.hamcrest.core.allOf;
	import org.hamcrest.core.not;
	import org.hamcrest.object.hasPropertyWithValue;
	
	use namespace supply_internals;
	
	/**
	 * 
	 * The Exclude tests are testing the inverse of the Filter Tests.
	 * 
	 * Half of the queries require a straight - TOTAL_ITEMS - EXPECTED_ITEMS and not() on the everyItem hamcrest matcher.
	 * 
	 * But the other half ( more complex ) queries need the query syntax changed to acheive the same result.
	 * 
	 * 
	 * @author jamieowen
	 */
	public class QueryFilterAndExcludeTest
	{
		public static var JAMIE:Photographer 	= new Photographer("JAMIE");
		public static var FRED:Photographer 	= new Photographer("FRED");
		public static var SARAH:Photographer 	= new Photographer("SARAH");
		
		public static var TOTAL_ITEMS:uint;
		
		public static var items:Vector.<Photo>;
		
		public static var TOTAL_ALL_SKYSCRAPER_EXCLUDING_SARAH:uint;
		public static var TOTAL_ALL_1p4_EXCLUDING_JAMIE:uint;
		public static var TOTAL_ALL_SARAH_EXCLUDING_70mm_EXCLUDING_1p4:uint;
			
		[BeforeClass]
		public static function setupQueryItems():void
		{
			
			var photos:Array = [
				"Sunny Day", 	SARAH, 	null,	new Date(),		35,		1.4,
				"Ugly Day", 	FRED, 	null, 	new Date(),		35, 	1.4,
				"Clouds", 		SARAH, 	null,	new Date(),		70,		1.4,
				"Clouds", 		JAMIE, 	null, 	new Date(),		15, 	5.6,
				"Duck Pond", 	FRED, 	null,	new Date(),		70,		1.4,
				"Duck Lake", 	JAMIE, 	null, 	new Date(),		15, 	2.0,
				"Skyscraper", 	JAMIE, 	null, 	new Date(),		15, 	1.4,
				"Skyscraper", 	SARAH, 	null, 	new Date(),		35, 	2.0,
				"Skyscraper", 	FRED, 	null, 	new Date(),		35, 	1.4,
				"Mars", 		JAMIE, 	null, 	new Date(),		15, 	1.4,
				"Moon", 		SARAH, 	null, 	new Date(),		15, 	2.0,
				"Saturn", 		SARAH, 	null, 	new Date(),		70, 	1.4
			];
			
			// expected lengths
			TOTAL_ITEMS = photos.length / 6;
			
			TOTAL_ALL_SKYSCRAPER_EXCLUDING_SARAH = 2;
			TOTAL_ALL_1p4_EXCLUDING_JAMIE = 6;
			TOTAL_ALL_SARAH_EXCLUDING_70mm_EXCLUDING_1p4 = 2;
			

			items = new Vector.<Photo>();
			var photo:Photo;
			// setup a list of items to use to run the matchers against.
			for( var i:int = 0; i<photos.length; i+=6 )
			{
				photo 				= new Photo();
				photo.title  		= photos[i];
				photo.author 		= photos[i+1];
				photo.tags 			= photos[i+2];
				photo.published 	= photos[i+3];
				photo.lens 			= photos[i+4];
				photo.focalRatio	= photos[i+5];
				
				items.push( photo );
			}
		}
		
		/**
		 * Helper function to pass in a single hamcrest matcher to check the results of the custom query matchers.
		 */
		private function createQueryHandler( matcher:Matcher):Function
		{
			
			var assert:Function = function( query:Query, options:QueryOptions ):void
			{				
				var match:IMatcher;
				
				var resultsAfter:Vector.<Photo> = items.slice(0,uint.MAX_VALUE);
				var results:Vector.<Photo>;
				var i:int;
				var model:IModel;
				
				for( var m:int = 0; m<query.matches.length; m++ )
				{
					match = query.matches[m];
					results = resultsAfter;
					resultsAfter = new Vector.<Photo>();
					for( i = 0; i<results.length; i++ ){
						model = results[i];
						if( match.match(model)){
							resultsAfter.push( model );
						}
					}
				}
				var message:String;
				for( i = 0; i<resultsAfter.length; i++ ){
					message += " " + resultsAfter[i];
				}
				
				assertThat( message, resultsAfter, matcher );

			};
			
			return assert;
		}
		
		/**
			TOTAL_ALL_SKYSCRAPER_EXCLUDING_SARAH = 2;
			TOTAL_ALL_1p4_EXCLUDING_JAMIE = 5;
			TOTAL_ALL_SARAH_EXCLUDING_70mm_EXCLUDING_2p = 2;
		 */
		
		[Test]
		public function test_queryFilterExclude_AllSkyscraper_Excluding_Sarah():void
		{
			var storage:QueryTestStorage = new QueryTestStorage();
			storage.onQuery = createQueryHandler( 
							allOf( 
								arrayWithSize(TOTAL_ALL_SKYSCRAPER_EXCLUDING_SARAH), 
								everyItem( allOf( 
									hasPropertyWithValue("title", "Skyscraper" ),
									not( hasPropertyWithValue("author", SARAH ) ) 
									) )
								) );

			var photos:Query = new Query(Photo,storage);
			photos.filter( "title" ).values( "Skyscraper" ).exclude("author").values(SARAH).all();
		}

		[Test]
		public function test_queryFilterExclude_All_1p4_Excluding_Jamie():void
		{
			var storage:QueryTestStorage = new QueryTestStorage();
			storage.onQuery = createQueryHandler( 
							allOf( 
								arrayWithSize(TOTAL_ALL_1p4_EXCLUDING_JAMIE), 
								everyItem( allOf( 
									hasPropertyWithValue("focalRatio", 1.4 ),
									not( hasPropertyWithValue("author", JAMIE ) ) 
									) )
								) );

			var photos:Query = new Query(Photo,storage);
			photos.filter( "focalRatio" ).values( 1.4 ).exclude("author").values(JAMIE).all();
		}

		[Test]
		public function test_queryFilterExclude_AllSarah_Exluding_70mm_Exluding_1p4():void
		{
			var storage:QueryTestStorage = new QueryTestStorage();
			storage.onQuery = createQueryHandler( 
							allOf( 
								arrayWithSize(TOTAL_ALL_SARAH_EXCLUDING_70mm_EXCLUDING_1p4), 
								everyItem( allOf( 
									hasPropertyWithValue("author", SARAH ),
									not( allOf( 
										hasPropertyWithValue("lens", 70), 
										hasPropertyWithValue("focalRatio", 1.4 ) 
										) ) 
									) )
								) );
								

			var photos:Query = new Query(Photo,storage);
			photos.filter( "author" ).values( SARAH ).exclude("lens").values(70).exclude("focalRatio").values(1.4).all();
		}
	}
}
