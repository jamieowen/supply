package suites {
	import tests.queries.ExecuteQueryFilterAndExcludeTest;
	import tests.queries.ExecuteQueryExcludeTest;
	import tests.queries.ExecuteQueryFilterTest;
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
		public var executeQueryFilter:ExecuteQueryFilterTest;
	
		[Test(order=3)]
		public var executeQueryExclude:ExecuteQueryExcludeTest;

		[Test(order=3)]
		public var executeQueryFilterAndExclude:ExecuteQueryFilterAndExcludeTest;

	}
}
