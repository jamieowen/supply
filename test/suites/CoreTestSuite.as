package suites {
	import tests.core.InjectionTest;
	import tests.core.RegisterTest;
	/**
	 * @author jamieowen
	 */
	[Suite]
	[RunWith("org.flexunit.runners.Suite")]
	public class CoreTestSuite
	{
		[Test(order=1)]
		public var registerTest:RegisterTest;
		
		[Test(order=2)]
		public var injectionTest:InjectionTest;
	}
}
