package suites {
	import tests.misc.SharedObjectTest;
	import tests.models.ReflectTest;
	import tests.models.SignalsTest;
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
		
		[Test]
		public var createTest:SharedObjectTest;
	}
}
