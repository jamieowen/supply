package tests.models {
	import mock.models.PrimitivesOnlyModel;
	import supply.Supply;
	/**
	 * @author jamieowen
	 */
	public class PrimitivesOnlyFieldsTest
	{
		[Test]
		public function testPrimitivesOnly():void
		{
			var primitivesModel:PrimitivesOnlyModel = new PrimitivesOnlyModel();
			primitivesModel.booleanField = true;
			primitivesModel.intField = -10;
			primitivesModel.uintField = 10;
			primitivesModel.numberField = 3.141592654;
			primitivesModel.arrayField = ["test", 0, 1.24, false, -1];
			primitivesModel.stringField = "Hello There";
			
			
		}
	}
}
