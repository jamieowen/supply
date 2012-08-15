package tests.queries {
	import org.hamcrest.core.allOf;
	import org.hamcrest.core.anyOf;
	import mock.models.Photographer;
	import org.hamcrest.collection.arrayWithSize;
	import org.hamcrest.collection.everyItem;
	import org.hamcrest.object.hasPropertyWithValue;
	import org.hamcrest.assertThat;
	import supply.api.IModel;
	import org.hamcrest.Matcher;
	import supply.queries.matchers.IMatcher;
	import supply.queries.QueryOptions;
	import mock.storage.QueryTestStorage;
	import mock.models.Photo;
	import supply.queries.Query;
	import supply.core.supply_internals;
	
	use namespace supply_internals;
	
	/**
	 * @author jamieowen
	 */
	public class QueryFilterTest
	{
		public static var JAMIE:Photographer 	= new Photographer("JAMIE");
		public static var FRED:Photographer 	= new Photographer("FRED");
		public static var SARAH:Photographer 	= new Photographer("SARAH");
		
		public static var TOTAL_ITEMS:uint;
		
		public static var items:Vector.<Photo>;
		
		public static var TOTAL_JAMIE:uint;
		public static var TOTAL_FRED:uint;
		public static var TOTAL_SARAH:uint;
		
		public static var TOTAL_SARAH_AND_1p4:uint = 3;
		public static var TOTAL_FRED_AND_70mm:uint = 1;
			
		public static var TOTAL_SKYSCRAPER_OR_CLOUDS:uint = 5;
		public static var TOTAL_MOON_OR_MARS_OR_SATURN:uint = 3;
		public static var TOTAL_MOON_OR_MARS_OR_SATURN_AND_SARAH:uint = 2;
		public static var TOTAL_SKYSCRAPER_AND_FRED_OR_SARAH:uint = 2;
		public static var TOTAL_SKYSCRAPER_AND_FRED_OR_SARAH_AND_1p4:uint = 1;
		public static var TOTAL_70mm_AND_SATURN_OR_CLOUDS:uint = 2;
			
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
			TOTAL_JAMIE = 4;
			TOTAL_FRED  = 3;
			TOTAL_SARAH = 5;
			TOTAL_ITEMS = photos.length / 6;
			
			// some logic exepcted result counts.
			TOTAL_SARAH_AND_1p4 = 3;
			TOTAL_FRED_AND_70mm = 1;
			
			TOTAL_SKYSCRAPER_OR_CLOUDS = 5;
			TOTAL_MOON_OR_MARS_OR_SATURN = 3;
			TOTAL_MOON_OR_MARS_OR_SATURN_AND_SARAH = 2;
			TOTAL_SKYSCRAPER_AND_FRED_OR_SARAH = 2;
			TOTAL_SKYSCRAPER_AND_FRED_OR_SARAH_AND_1p4 = 1;
			TOTAL_70mm_AND_SATURN_OR_CLOUDS = 2;
			

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
		
		[Test]
		public function test_queryFilter_all():void
		{
			var storage:QueryTestStorage = new QueryTestStorage();
			storage.onQuery = createQueryHandler( arrayWithSize(TOTAL_ITEMS) );
			var photos:Query = new Query(Photo,storage);
			photos.all();
		}
		
		[Test]
		public function test_queryFilter_Jamie():void
		{
			var storage:QueryTestStorage = new QueryTestStorage();
			storage.onQuery = createQueryHandler( 
							allOf( 
								arrayWithSize(TOTAL_JAMIE), 
								everyItem( 
									hasPropertyWithValue("author", JAMIE ) 
									)
								) );

			var photos:Query = new Query(Photo,storage);
			photos.filter( "author" ).values( JAMIE ).all();
		}

		[Test]
		public function test_queryFilter_Fred():void
		{
			var storage:QueryTestStorage = new QueryTestStorage();
			storage.onQuery = createQueryHandler( 
							allOf( 
								arrayWithSize(TOTAL_FRED), 
								everyItem( 
									hasPropertyWithValue("author", FRED ) 
									)
								) );
								
			var photos:Query = new Query(Photo,storage);
			photos.filter( "author" ).values( FRED ).all();
		}

		[Test]
		public function test_queryFilter_Sarah():void
		{
			var storage:QueryTestStorage = new QueryTestStorage();
			storage.onQuery = createQueryHandler( 
							allOf( 
								arrayWithSize(TOTAL_SARAH), 
								everyItem( 
									hasPropertyWithValue("author", SARAH ) 
									)
								) );
								
			var photos:Query = new Query(Photo,storage);
			photos.filter( "author" ).values( SARAH ).all();
		}
		

		
		[Test]
		public function test_queryFilter_SarahAnd1p4():void
		{
			var storage:QueryTestStorage = new QueryTestStorage();
			storage.onQuery = createQueryHandler( 
							allOf( 
								arrayWithSize(TOTAL_SARAH_AND_1p4), 
								everyItem( allOf( 
									hasPropertyWithValue("author", SARAH ),
									hasPropertyWithValue("focalRatio", 1.4 )
									) )
								) );
							
			var photos:Query = new Query(Photo,storage);
			photos.filter( "author", "focalRatio" ).values( SARAH, 1.4 ).all();
		}

		[Test]
		public function test_queryFilter_SarahAnd1p4Variation():void
		{
			var storage:QueryTestStorage = new QueryTestStorage();
			storage.onQuery = createQueryHandler( 
							allOf( 
								arrayWithSize(TOTAL_SARAH_AND_1p4), 
								everyItem( allOf( 
									hasPropertyWithValue("author", SARAH ),
									hasPropertyWithValue("focalRatio", 1.4 )
									) )
								) );
							
			var photos:Query = new Query(Photo,storage);
			photos.filter( "author" ).values( SARAH ).filter( "focalRatio" ).values( 1.4 ).all();
		}

		[Test]
		public function test_queryFilter_FredAnd70mm():void
		{
			var storage:QueryTestStorage = new QueryTestStorage();
			storage.onQuery = createQueryHandler( 
							allOf( 
								arrayWithSize(TOTAL_FRED_AND_70mm), 
								everyItem( allOf( 
									hasPropertyWithValue("author", FRED ),
									hasPropertyWithValue("lens", 70 )
									) )
								) );

			var photos:Query = new Query(Photo,storage);
			photos.filter( "lens", "author" ).values( 70, FRED ).all();
		}

		[Test]
		public function test_queryFilter_FredAnd70mmVariation():void
		{
			var storage:QueryTestStorage = new QueryTestStorage();
			storage.onQuery = createQueryHandler( 
							allOf( 
								arrayWithSize(TOTAL_FRED_AND_70mm), 
								everyItem( allOf( 
									hasPropertyWithValue("author", FRED ),
									hasPropertyWithValue("lens", 70 )
									) )
								) );

			var photos:Query = new Query(Photo,storage);
			photos.filter( "lens" ).values( 70, 120, 200 ).filter("author").values(FRED).all();
		}

		[Test]
		public function test_queryFilter_SkyscaperOrClouds():void
		{
			var storage:QueryTestStorage = new QueryTestStorage();
			storage.onQuery = createQueryHandler( 
							allOf( 
								arrayWithSize(TOTAL_SKYSCRAPER_OR_CLOUDS), 
								everyItem( anyOf( 
									hasPropertyWithValue("title", "Clouds" ),
									hasPropertyWithValue("title", "Skyscraper" )
									) )
								) );

			var photos:Query = new Query(Photo,storage);
			photos.filter( "title" ).values( "Skyscraper", "Clouds").all();
		}

		[Test]
		public function test_queryFilter_MoonOrMarsOrSaturn():void
		{
			var storage:QueryTestStorage = new QueryTestStorage();
			storage.onQuery = createQueryHandler( 
							allOf( 
								arrayWithSize(TOTAL_MOON_OR_MARS_OR_SATURN), 
								everyItem( anyOf( 
									hasPropertyWithValue("title", "Moon" ),
									hasPropertyWithValue("title", "Mars" ),
									hasPropertyWithValue("title", "Saturn" )
									) )
								) );
			var photos:Query = new Query(Photo,storage);
			photos.filter( "title" ).values( "Moon", "Mars", "Saturn" ).all();
		}

		[Test]
		public function test_queryFilter_MoonOrMarsOrSaturnAndSarah():void
		{
			var storage:QueryTestStorage = new QueryTestStorage();
			storage.onQuery = createQueryHandler( 
							allOf( 
								arrayWithSize(TOTAL_MOON_OR_MARS_OR_SATURN_AND_SARAH), 
								everyItem( allOf( 
									anyOf( 
										hasPropertyWithValue("title", "Moon" ),
										hasPropertyWithValue("title", "Mars" ),
										hasPropertyWithValue("title", "Saturn" )
										),
									hasPropertyWithValue("author", SARAH )
								 	) ) 
								) );

			var photos:Query = new Query(Photo,storage);
			photos.filter( "title" ).values( "Moon", "Mars", "Saturn" ).filter( "author").values( SARAH ).all();
		}

		[Test]
		public function test_queryFilter_MoonOrMarsOrSaturnAndSarahVariation():void
		{
			var storage:QueryTestStorage = new QueryTestStorage();
			storage.onQuery = createQueryHandler( 
							allOf( 
								arrayWithSize(TOTAL_MOON_OR_MARS_OR_SATURN_AND_SARAH), 
								everyItem( allOf( 
									anyOf( 
										hasPropertyWithValue("title", "Moon" ),
										hasPropertyWithValue("title", "Mars" ),
										hasPropertyWithValue("title", "Saturn" )
										),
									hasPropertyWithValue("author", SARAH )
								 	) ) 
								) );
			var photos:Query = new Query(Photo,storage);
			photos.filter( "author").values( SARAH ).filter( "title" ).values( "Moon", "Mars", "Saturn" ).all();
		}

		[Test]
		public function test_queryFilter_SkyScraper_And_Fred_Or_Sarah():void
		{
			var storage:QueryTestStorage = new QueryTestStorage();
			storage.onQuery = createQueryHandler( 
							allOf( 
								arrayWithSize(TOTAL_SKYSCRAPER_AND_FRED_OR_SARAH), 
								everyItem( allOf( 
									anyOf( 
										hasPropertyWithValue("author", FRED ),
										hasPropertyWithValue("author", SARAH )
										),
									hasPropertyWithValue("title", "Skyscraper" )
								 	) ) 
								) );
								
			var photos:Query = new Query(Photo,storage);
			photos.filter( "title" ).values( "Skyscraper" ).filter( "author").values( FRED, SARAH ).all();
		}

		[Test]
		public function test_queryFilter_SkyScraper_And_Fred_Or_Sarah_And_1p4():void
		{
			var storage:QueryTestStorage = new QueryTestStorage();
			storage.onQuery = createQueryHandler( 
							allOf( 
								arrayWithSize(TOTAL_SKYSCRAPER_AND_FRED_OR_SARAH_AND_1p4), 
								everyItem( allOf( 
									anyOf( 
										hasPropertyWithValue("author", FRED ),
										hasPropertyWithValue("author", SARAH )
										),
									hasPropertyWithValue("title", "Skyscraper" ),
									hasPropertyWithValue("focalRatio", 1.4 )
								 	) ) 
								) );
											
			var photos:Query = new Query(Photo,storage);
			photos.filter( "title" ).values( "Skyscraper" ).filter( "author").values( FRED, SARAH ).filter("focalRatio").values(1.4).all();
		}

		[Test]
		public function test_queryFilter_SkyScraper_And_Fred_Or_Sarah_And_1p4Variation():void
		{
			var storage:QueryTestStorage = new QueryTestStorage();
			storage.onQuery = createQueryHandler( 
							allOf( 
								arrayWithSize(TOTAL_SKYSCRAPER_AND_FRED_OR_SARAH_AND_1p4), 
								everyItem( allOf( 
									anyOf( 
										hasPropertyWithValue("author", FRED ),
										hasPropertyWithValue("author", SARAH )
										),
									hasPropertyWithValue("title", "Skyscraper" ),
									hasPropertyWithValue("focalRatio", 1.4 )
								 	) ) 
								) );
			var photos:Query = new Query(Photo,storage);
			photos.filter( "focalRatio" ).values( 1.4 ).filter( "title").values( "Skyscraper" ).filter("author").values(FRED,SARAH).all();
		}

		/**
			TOTAL_SARAH_AND_1p4 = 3;
			TOTAL_FRED_AND_70mm = 1;
			
			TOTAL_SKYSCRAPER_OR_CLOUDS = 5;
			TOTAL_MOON_OR_MARS_OR_SATURN = 3;
			TOTAL_MOON_OR_MARS_OR_SATURN_AND_SARAH = 2;
			TOTAL_SKYSCRAPER_AND_FRED_OR_SARAH = 2;
			TOTAL_SKYSCRAPER_AND_FRED_OR_SARAH_AND_1p4 = 1;
			TOTAL_70mm_AND_SATURN_OR_CLOUDS = 2;
		 */
		 
		[Test]
		public function test_queryFilter_70mm_And_Saturn_Or_Clouds():void
		{
			var storage:QueryTestStorage = new QueryTestStorage();
			storage.onQuery = createQueryHandler( 
							allOf( 
								arrayWithSize(TOTAL_70mm_AND_SATURN_OR_CLOUDS), 
								everyItem( allOf( 
									anyOf( 
										hasPropertyWithValue("title", "Clouds" ),
										hasPropertyWithValue("title", "Saturn" )
										),
									hasPropertyWithValue("lens", 70 )
								 	) ) 
								) );
								
			var photos:Query = new Query(Photo,storage);
			photos.filter( "lens" ).values( 70 ).filter( "title").values( "Saturn", "Clouds" ).all();
		}
	}
}
