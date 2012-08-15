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
	import org.hamcrest.date.dateAfter;
	import org.hamcrest.date.dateBetween;
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
	public class QueryFilterExcludeDateTest
	{
		public static var JAMIE:Photographer 	= new Photographer("JAMIE");
		public static var FRED:Photographer 	= new Photographer("FRED");
		public static var SARAH:Photographer 	= new Photographer("SARAH");
		
		public static var TOTAL_ITEMS:uint;
		
		public static var items:Vector.<Photo>;
		
		public static var TOTAL_ALL_SARAH_GREATER_JAN1st_2011:uint;
		public static var TOTAL_ALL_GREATER_THAN_DEC1st_2004_LESS_THAN_JAN1st_2010:uint;
		public static var TOTAL_ALL_GREATER_THAN_DEC1st_2004_LESS_THAN_JAN1st_2010_EXCLUDE_15mm:uint;
		[BeforeClass]
		public static function setupQueryItems():void
		{
			
			var photos:Array = [
				"Sunny Day", 	SARAH, 	null,	new Date(2010,0,23),		35,		1.4,
				"Ugly Day", 	FRED, 	null, 	new Date(2010,4,12),		35, 	1.4,
				"Clouds", 		SARAH, 	null,	new Date(2010,3,9 ),		70,		1.4,
				"Clouds", 		JAMIE, 	null, 	new Date(1971,3,23),		15, 	5.6,
				"Duck Pond", 	FRED, 	null,	new Date(1956,3,23),		70,		1.4,
				"Duck Lake", 	JAMIE, 	null, 	new Date(1930,3,23),		15, 	2.0,
				"Skyscraper", 	JAMIE, 	null, 	new Date(2012,2,7),			15, 	1.4,
				"Skyscraper", 	SARAH, 	null, 	new Date(2020,9,23),		35, 	2.0,
				"Skyscraper", 	FRED, 	null, 	new Date(2004,8,2 ),		35, 	1.4,
				"Mars", 		JAMIE, 	null, 	new Date(2005,1,2 ),		15, 	1.4,
				"Moon", 		SARAH, 	null, 	new Date(2010,8,4),			15, 	2.0,
				"Saturn", 		SARAH, 	null, 	new Date(2011,8,17),		70, 	1.4
			];
			
			// expected lengths
			TOTAL_ITEMS = photos.length / 6;
			
			TOTAL_ALL_SARAH_GREATER_JAN1st_2011 = 2;
			TOTAL_ALL_GREATER_THAN_DEC1st_2004_LESS_THAN_JAN1st_2010 = 2;
			TOTAL_ALL_GREATER_THAN_DEC1st_2004_LESS_THAN_JAN1st_2010_EXCLUDE_15mm = 1;
			

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
		public function test_queryFilterExclude_GreaterThan_Dec1st2004_LessThan_Jan1st2010():void
		{
			var d1:Date = new Date(2004,0,1);
			var d2:Date = new Date(2010,0,1);
			
			var storage:QueryTestStorage = new QueryTestStorage();
			storage.onQuery = createQueryHandler( 
							allOf( 
								arrayWithSize(TOTAL_ALL_GREATER_THAN_DEC1st_2004_LESS_THAN_JAN1st_2010), 
								everyItem( 
									hasPropertyWithValue( "published",dateBetween(d1,d2) )
								 	)
								) );
			
			var photos:Query = new Query(Photo,storage);
			photos.filter( "published__gt", "published__lt" ).values( d1, d2).all();
		}

		[Test]
		public function test_queryFilterExclude_GreaterThan_Dec1st2004_LessThan_Jan1st2010_Exclude15mm():void
		{
			var d1:Date = new Date(2004,0,1);
			var d2:Date = new Date(2010,0,1);
			
			var storage:QueryTestStorage = new QueryTestStorage();
			storage.onQuery = createQueryHandler( 
							allOf( 
								arrayWithSize(TOTAL_ALL_GREATER_THAN_DEC1st_2004_LESS_THAN_JAN1st_2010_EXCLUDE_15mm), 
								everyItem( allOf( 
									hasPropertyWithValue( "published",dateBetween(d1,d2) ),
									not( hasPropertyWithValue( "lens", 15 )
								 	) ) )
								) );
			
			var photos:Query = new Query(Photo,storage);
			photos.filter( "published__gt", "published__lt" ).values( d1, d2).exclude( "lens" ).values( 15 ).all();
		}

		[Test]
		public function test_queryFilterExclude_AllSarah_GreaterThan_Jan1st_2011():void
		{
			var d1:Date = new Date(2011,0,1);
			
			var storage:QueryTestStorage = new QueryTestStorage();
			storage.onQuery = createQueryHandler( 
							allOf( 
								arrayWithSize(TOTAL_ALL_SARAH_GREATER_JAN1st_2011), 
								everyItem( allOf(
									hasPropertyWithValue("published", dateAfter(d1) ),
									hasPropertyWithValue("author", SARAH )  
									))
								) );
			

			var photos:Query = new Query(Photo,storage);
			photos.filter("author").values(SARAH).filter( "published__gt" ).values( d1 ).all();
		}


	}
}
