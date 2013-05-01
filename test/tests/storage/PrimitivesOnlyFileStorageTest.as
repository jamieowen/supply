package tests.storage {
	import mock.models.PrimitivesOnlyTestModel;
	/**
	 * @author jamieowen
	 */
	public class PrimitivesOnlyFileStorageTest
	{
		
		[Test(order=1)]
		public function testSaveNullData():void
		{
			var primitivesModel:PrimitivesOnlyTestModel = new PrimitivesOnlyTestModel();
			primitivesModel.save();
		}
		
		public function testSavePopulatedData():void
		{
			var primitivesModel:PrimitivesOnlyTestModel = new PrimitivesOnlyTestModel();
			primitivesModel.save();
		}
		
		public function testSaveAgain():void
		{
			
		}
		
		public function testDelete():void
		{
			
		}
		
		public function testSync():void
		{
			
		}
	}
}
