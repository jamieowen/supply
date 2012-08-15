package suites {
	import tests.models.SignalsTest;
	import tests.models.ReflectTest;
	/**
	 * @author jamieowen
	 */
	[Suite]
	[RunWith("org.flexunit.runners.Suite")]
	public class ModelTestSuite
	{
		[Test(order=1)]
		public var reflectTest:ReflectTest;
		
		[Test(order=2)]
		public var signalsTest:SignalsTest;
	}
}
