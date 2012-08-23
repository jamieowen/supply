package suites {
	import tests.serialization.ObjectSerializerTest;
	/**
	 * @author jamieowen
	 */
	[Suite]
	[RunWith("org.flexunit.runners.Suite")]
	public class SerializationTestSuite
	{
		[Test(order=1)]
		public var objectTest:ObjectSerializerTest;
		
		//[Test(order=2)]
		//public var injectionTest:InjectionTest;
	}
}
