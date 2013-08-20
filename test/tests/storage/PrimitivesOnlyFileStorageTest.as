package tests.storage {
	import mock.models.PrimitivesOnlyTestModel;
	/**
	 * @author jamieowen
	 */
	public class PrimitivesOnlyFileStorageTest
	{
		/**
		 * Create a new model and save it.
		 */
		[Test(order=1)]
		public function testCreation():void
		{
			var primitivesModel:PrimitivesOnlyTestModel = new PrimitivesOnlyTestModel();
			primitivesModel.populateDefaults();
			primitivesModel.save();
		}
		
		/**
		 * Query the contents of the storage after the model above has been saved.
		 */
		public function testQuery():void
		{
			
		}		
		
		/**
		 * Query the model, make changes but then call sunc to revert the changes.
		 */
		public function testSync():void
		{
			
		}

		/**
		 * Make changes to the model and save it.
		 * Query on the field change to check the change has been saved.
		 */
		public function testSaveAgain():void
		{
			
		}
		
		/**
		 * Remove the initial model and query to check the result count is 0.
		 */
		public function testDelete():void
		{
			
		}		

	}
}
