package suites
{
	import tests.storage.PrimitivesOnlyFileStorageTest;
	
	[Suite]
	[RunWith("org.flexunit.runners.Suite")]	 
	public class StorageSuite
	{
		[Test(order=1)]
		public var fileStorageTest:PrimitivesOnlyFileStorageTest;	
	}
}
