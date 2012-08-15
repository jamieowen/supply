package suites {
	import tests.queries.QueryFilterExcludeDateTest;
	import tests.queries.QueryFilterAndExcludeTest;
	import tests.queries.QueryExcludeTest;
	import tests.queries.QueryFilterTest;
	import tests.queries.ParsePropertyToMatchersTest;
	/**
	 * @author jamieowen
	 */
	[Suite]
	[RunWith("org.flexunit.runners.Suite")]
	public class QueryTestSuite
	{
		[Test(order=1)]
		public var parsePropertiesToMatchersTest:ParsePropertyToMatchersTest;
		
		[Test(order=2)]
		public var executeQueryFilter:QueryFilterTest;
	
		[Test(order=3)]
		public var executeQueryExclude:QueryExcludeTest;

		[Test(order=4)]
		public var executeQueryFilterAndExclude:QueryFilterAndExcludeTest;

		[Test(order=5)]
		public var executeQueryFilterAndExcludeDate:QueryFilterExcludeDateTest;

	}
}
