package tests.models {
	import org.flexunit.asserts.assertTrue;
	import mock.models.PrimitivesOnlyTestModel;

	import org.flexunit.asserts.assertEquals;
	/**
	 * @author jamieowen
	 */
	public class PrimitivesOnlyFieldsTest
	{
		[Test]
		public function testPrimitivesOnly():void
		{
			var primitivesModel:PrimitivesOnlyTestModel = new PrimitivesOnlyTestModel();
			
			var expectedFields:Array = [
				"booleanField",
				"intField",
				"uintField", 
				"numberField", 
				"stringField",
				"dateField",
				"xmlField",
				"arrayField",
				"arrayMultiField",
				"vectorBooleanField",
				"vectorIntField",
				"vectorUIntField",
				"vectorNumberField",
				"vectorStringField",
				"vectorDateField",
				"vectorXMLField",
				"vectorArrayMultiField" ];
			
			// TEST LENGTH 	
			assertEquals( "Number of fields did not match.", expectedFields.length, primitivesModel.fields.numFields);	
			
			// TEST EXPECTED FIELD NAMES		
			var fieldNames:Array = primitivesModel.fields.fieldNames;
			var ii:int;
			var found:Boolean;
			for( var i:int = 0; i<expectedFields.length; i++ )
			{
				found = false;
				for( ii = 0; ii<fieldNames.length; ii++ ){
					if( fieldNames[ii] == expectedFields[i] ){
						found = true;
						continue;
					}
				}
				assertTrue( "Expected field not found :" + expectedFields[i], found );
			}
			
			
		}
	}
}
