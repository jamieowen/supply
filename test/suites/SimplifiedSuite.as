package suites
{
	import tests.models.PrimitivesOnlyFieldsTest;
	[Suite]
	[RunWith("org.flexunit.runners.Suite")]	 
	public class SimplifiedSuite
	{
		[Test(order=1)]
		public var fieldsTest:PrimitivesOnlyFieldsTest;		
	}
}
