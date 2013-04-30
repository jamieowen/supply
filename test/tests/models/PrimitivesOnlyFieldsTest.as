package tests.models
{
	import org.flexunit.asserts.assertFalse;
	import matchers.arrayExact;
	import mock.models.PrimitivesOnlyTestModel;
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertTrue;
	import org.hamcrest.assertThat;

	import flash.utils.getQualifiedClassName;

	import supply.fields.DateField;
	
	/**
	 * @author jamieowen
	 */
	public class PrimitivesOnlyFieldsTest
	{
		
		/**
		 * Tests the field names and field length count is accurate.
		 */
		[Test(order=1)]
		public function testFieldNamesAndLength():void
		{
			var primitivesModel:PrimitivesOnlyTestModel = new PrimitivesOnlyTestModel();
			primitivesModel.populateDefaults();
			
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
		
		/**
		 * Tests that the serialized types are in the correct format.
		 * So that we are always outputting low level primitive actionscript types.
		 * Boolean, int, uint, Number, Array and String.
		 */
		[Test(order=2)]
		public function testSerializedValuesTypes():void
		{
			var primitivesModel:PrimitivesOnlyTestModel = new PrimitivesOnlyTestModel();
			primitivesModel.populateDefaults();
				
			var testSerializedType:Function = function( value:* ):Boolean
			{ 
				var ok:Boolean = false;
				if( value is Boolean || value is int || value is uint || value is String || value is Number || getQualifiedClassName(value) == "Object" ){
					ok = true;
				}else
				if( value is Array ){
					var i:int;
					var a:Array = value as Array;
					ok = true;
					for( i = 0; i<a.length; i++ ){
						ok = ok && testSerializedType(a[i]);
					}
				}
				assertTrue( "A returned serialized type was not ok. Expected types should be Boolean,int,uint,String,Number and Array. But type was " + getQualifiedClassName(value), ok );
				return ok;
			};
			
			// ASSERT INDIVIDUAL SERIALIZED FIELD VALUES
			var fieldNames:Array = primitivesModel.fields.fieldNames;
			var fieldName:String;
			var serializedValue:*;
			var i:int;
			for( i = 0; i<fieldNames.length; i++ )
			{
				fieldName = fieldNames[i];
				serializedValue = primitivesModel.fields.getSerializedValue(fieldName);  
				testSerializedType( serializedValue );
			}	
		}
		
		/**
		 * Helper to allow comparison of of serialized output with an expected array.
		 */
		private function convertArrayToExpectedSerializedOutput(array:Array):Array
		{
			var item:*;
			var type:String;
			var result:Array = [];
			for( var i:int = 0; i<array.length; i++ )
			{
				item = array[i];
				type = getQualifiedClassName(item);
				if( item is XML ){
					item = (item as XML).toString();
				}else
				if( item is Date ){
					item = (item as Date).getTime();
				}else
				if( item is Array){
					item = convertArrayToExpectedSerializedOutput(item);
				}
				
				result.push( {type:type, value:item} );
			}
			return result;
		}
		/**
		 * Test that the serialized output matches the original Models field values.
		 */
		[Test(order=3)]
		public function testSerializedOutput():void
		{
			var primitivesModel:PrimitivesOnlyTestModel = new PrimitivesOnlyTestModel();
			primitivesModel.populateDefaults();
						
			// ASSERT SERIALIZED MODEL FIELDS VALUES. 
			var fieldValue:Object;
			var fieldNames:Array = primitivesModel.fields.fieldNames;
			var fieldName:String;			
			var serializedModel:Object = primitivesModel.fields.toObject();
			var i:int;
			
			for( i = 0; i<fieldNames.length; i++ )
			{
				fieldName = fieldNames[i];
				fieldValue = serializedModel[fieldName];
				
				switch( fieldName ){ 
					case "dateField":
						assertEquals( "The field '" + fieldName + "' did not serialize correctly.", primitivesModel.dateField, fieldValue );
						break;
					case "xmlField":
						assertEquals( "The field '" + fieldName + "' did not serialize correctly.", primitivesModel.xmlField, fieldValue );
						break;
					case "arrayField":
						assertThat( "The field '" + fieldName + "' did not serialize correctly.", fieldValue as Array, arrayExact( convertArrayToExpectedSerializedOutput([PrimitivesOnlyTestModel.BOOLEAN_VALUE,PrimitivesOnlyTestModel.INT_VALUE,PrimitivesOnlyTestModel.UINT_VALUE,PrimitivesOnlyTestModel.NUMBER_VALUE,PrimitivesOnlyTestModel.STRING_VALUE,PrimitivesOnlyTestModel.DATE_VALUE,PrimitivesOnlyTestModel.XML_VALUE]) ) );
						break;
					case "arrayMultiField":
						assertThat( "The field '" + fieldName + "' did not serialize correctly.", fieldValue as Array, arrayExact( convertArrayToExpectedSerializedOutput([PrimitivesOnlyTestModel.ARRAYMULTI_VALUE,PrimitivesOnlyTestModel.ARRAYMULTI_VALUE,PrimitivesOnlyTestModel.ARRAYMULTI_VALUE,PrimitivesOnlyTestModel.ARRAYMULTI_VALUE ]) ) );
						break;
					case "vectorBooleanField":
						assertThat( "The field '" + fieldName + "' did not serialize correctly.", fieldValue as Array, arrayExact([PrimitivesOnlyTestModel.BOOLEAN_VALUE,PrimitivesOnlyTestModel.BOOLEAN_VALUE,PrimitivesOnlyTestModel.BOOLEAN_VALUE,PrimitivesOnlyTestModel.BOOLEAN_VALUE]) );
						break;
					case "vectorIntField":
						assertThat( "The field '" + fieldName + "' did not serialize correctly.", fieldValue as Array, arrayExact([PrimitivesOnlyTestModel.INT_VALUE,PrimitivesOnlyTestModel.INT_VALUE,PrimitivesOnlyTestModel.INT_VALUE,PrimitivesOnlyTestModel.INT_VALUE]) );		
						break;
					case "vectorUIntField":
						assertThat( "The field '" + fieldName + "' did not serialize correctly.", fieldValue as Array, arrayExact([PrimitivesOnlyTestModel.UINT_VALUE,PrimitivesOnlyTestModel.UINT_VALUE,PrimitivesOnlyTestModel.UINT_VALUE,PrimitivesOnlyTestModel.UINT_VALUE]) );
						break;
					case "vectorNumberField":
						assertThat( "The field '" + fieldName + "' did not serialize correctly.", fieldValue as Array, arrayExact([PrimitivesOnlyTestModel.NUMBER_VALUE,PrimitivesOnlyTestModel.NUMBER_VALUE,PrimitivesOnlyTestModel.NUMBER_VALUE,PrimitivesOnlyTestModel.NUMBER_VALUE]) );
						break;
					case "vectorStringField":
						assertThat( "The field '" + fieldName + "' did not serialize correctly.", fieldValue as Array, arrayExact([PrimitivesOnlyTestModel.STRING_VALUE,PrimitivesOnlyTestModel.STRING_VALUE,PrimitivesOnlyTestModel.STRING_VALUE,PrimitivesOnlyTestModel.STRING_VALUE]) );
						break;
					case "vectorDateField":
						assertThat( "The field '" + fieldName + "' did not serialize correctly.", fieldValue as Array, arrayExact([PrimitivesOnlyTestModel.DATE_VALUE.getTime(),PrimitivesOnlyTestModel.DATE_VALUE.getTime(),PrimitivesOnlyTestModel.DATE_VALUE.getTime(),PrimitivesOnlyTestModel.DATE_VALUE.getTime()]) );
						break;
					case "vectorXMLField":
						assertThat( "The field '" + fieldName + "' did not serialize correctly.", fieldValue as Array, arrayExact([PrimitivesOnlyTestModel.XML_VALUE.toString(),PrimitivesOnlyTestModel.XML_VALUE.toString(),PrimitivesOnlyTestModel.XML_VALUE.toString(),PrimitivesOnlyTestModel.XML_VALUE.toString() ]) );
						break;
					case "vectorArrayMultiField":
						trace( fieldName );
						var multi:Array = convertArrayToExpectedSerializedOutput(PrimitivesOnlyTestModel.ARRAYMULTI_VALUE);
						assertThat( "The field '" + fieldName + "' did not serialize correctly.", fieldValue as Array, arrayExact( [ multi,multi,multi,multi ]) );
						break;
					default :
						assertEquals( "The field '" + fieldName + "' did not serialize correctly.", fieldValue, primitivesModel[fieldName] );
				}
			}			
		}
		
		/**
		 * Converts a vector for testing with arrayExact. Should create a vectorExact but this will do.
		 * Were not converting possibilties of 2D Vectors. As no unit test is setup for this.
		 */
		private function convertVectorToArray(v:*):Array
		{
			var a:Array = [];
			for( var i:int = 0; i<v.length; i++ ){
				a.push( v[i] );	
			}
			return a;
		}
		/**
		 * Test that we can correctly deserialize the Model from an serialized one.
		 */
		[Test(order=4)]
		public function testDeserialization():void
		{
			// TEST DESERIALIZE MODEL OBJECT.
			
			var primitivesModel:PrimitivesOnlyTestModel = new PrimitivesOnlyTestModel();
			primitivesModel.populateDefaults();
			
			var serializedModel:Object = primitivesModel.fields.toObject();
			var unpopulatedPrimitivesModel:PrimitivesOnlyTestModel = new PrimitivesOnlyTestModel();
			
			unpopulatedPrimitivesModel.fields.fromObject( serializedModel );
			
			var fieldName:String;
			var fieldNames:Array = primitivesModel.fields.fieldNames;
			var fieldValue:*;
			
			for( var i:int = 0; i<fieldNames.length; i++ )
			{
				fieldName = fieldNames[i];
				fieldValue = unpopulatedPrimitivesModel.fields.getValue(fieldName);
				
				switch( fieldName ){ 
					case "dateField":
						assertEquals( "The field '" + fieldName + "' did not deserialize correctly.", (fieldValue as Date).getTime(), primitivesModel.dateField.getTime() );
						break;
					case "xmlField":
						assertEquals( "The field '" + fieldName + "' did not deserialize correctly.", (fieldValue as XML).toString(), primitivesModel.xmlField.toString() );
						break;
					case "arrayField":
						assertThat( "The field '" + fieldName + "' did not deserialize correctly.", fieldValue, arrayExact([PrimitivesOnlyTestModel.BOOLEAN_VALUE,PrimitivesOnlyTestModel.INT_VALUE,PrimitivesOnlyTestModel.UINT_VALUE,PrimitivesOnlyTestModel.NUMBER_VALUE,PrimitivesOnlyTestModel.STRING_VALUE,PrimitivesOnlyTestModel.DATE_VALUE,PrimitivesOnlyTestModel.XML_VALUE]) );
						break;
					case "arrayMultiField":
						assertThat( "The field '" + fieldName + "' did not deserialize correctly.", fieldValue, arrayExact([PrimitivesOnlyTestModel.ARRAYMULTI_VALUE,PrimitivesOnlyTestModel.ARRAYMULTI_VALUE,PrimitivesOnlyTestModel.ARRAYMULTI_VALUE,PrimitivesOnlyTestModel.ARRAYMULTI_VALUE ]) );
						break;
					case "vectorBooleanField":
						assertThat( "The field '" + fieldName + "' did not deserialize correctly.", convertVectorToArray(fieldValue), arrayExact([PrimitivesOnlyTestModel.BOOLEAN_VALUE,PrimitivesOnlyTestModel.BOOLEAN_VALUE,PrimitivesOnlyTestModel.BOOLEAN_VALUE,PrimitivesOnlyTestModel.BOOLEAN_VALUE]) );
						break;
					case "vectorIntField":
						assertThat( "The field '" + fieldName + "' did not deserialize correctly.", convertVectorToArray(fieldValue), arrayExact([PrimitivesOnlyTestModel.INT_VALUE,PrimitivesOnlyTestModel.INT_VALUE,PrimitivesOnlyTestModel.INT_VALUE,PrimitivesOnlyTestModel.INT_VALUE]) );		
						break;
					case "vectorUIntField":
						assertThat( "The field '" + fieldName + "' did not deserialize correctly.", convertVectorToArray(fieldValue), arrayExact([PrimitivesOnlyTestModel.UINT_VALUE,PrimitivesOnlyTestModel.UINT_VALUE,PrimitivesOnlyTestModel.UINT_VALUE,PrimitivesOnlyTestModel.UINT_VALUE]) );
						break;
					case "vectorNumberField":
						assertThat( "The field '" + fieldName + "' did not deserialize correctly.", convertVectorToArray(fieldValue), arrayExact([PrimitivesOnlyTestModel.NUMBER_VALUE,PrimitivesOnlyTestModel.NUMBER_VALUE,PrimitivesOnlyTestModel.NUMBER_VALUE,PrimitivesOnlyTestModel.NUMBER_VALUE]) );
						break;
					case "vectorStringField":
						assertThat( "The field '" + fieldName + "' did not deserialize correctly.", convertVectorToArray(fieldValue), arrayExact([PrimitivesOnlyTestModel.STRING_VALUE,PrimitivesOnlyTestModel.STRING_VALUE,PrimitivesOnlyTestModel.STRING_VALUE,PrimitivesOnlyTestModel.STRING_VALUE]) );
						break;
					case "vectorDateField":
						assertThat( "The field '" + fieldName + "' did not deserialize correctly.", convertVectorToArray(fieldValue), arrayExact([PrimitivesOnlyTestModel.DATE_VALUE,PrimitivesOnlyTestModel.DATE_VALUE,PrimitivesOnlyTestModel.DATE_VALUE,PrimitivesOnlyTestModel.DATE_VALUE]) );
						break;
					case "vectorXMLField":
						assertThat( "The field '" + fieldName + "' did not deserialize correctly.", convertVectorToArray(fieldValue), arrayExact([PrimitivesOnlyTestModel.XML_VALUE,PrimitivesOnlyTestModel.XML_VALUE,PrimitivesOnlyTestModel.XML_VALUE,PrimitivesOnlyTestModel.XML_VALUE ]) );
						break;
					case "vectorArrayMultiField":
						assertThat( "The field '" + fieldName + "' did not deserialize correctly.", convertVectorToArray(fieldValue), arrayExact([PrimitivesOnlyTestModel.ARRAYMULTI_VALUE,PrimitivesOnlyTestModel.ARRAYMULTI_VALUE,PrimitivesOnlyTestModel.ARRAYMULTI_VALUE,PrimitivesOnlyTestModel.ARRAYMULTI_VALUE ]) );
						break;
					default :
						assertEquals( "The field '" + fieldName + "' did not deserialize correctly.", fieldValue, primitivesModel[fieldName] );
				
				}
			}	
		}
		
		/**
		 * Test that dirty values are functioning correctly.
		 */
		[Test(order=5)]
		public function testSyncValuesAndDirty():void
		{
			var primitivesModel:PrimitivesOnlyTestModel = new PrimitivesOnlyTestModel();
			var fieldName:String;
			var fieldNames:Array = primitivesModel.fields.fieldNames;
			
			// all fields should be dirty on first creation.
			for( var i:int = 0; i<fieldNames.length; i++ )
			{
				fieldName = fieldNames[i];
				assertTrue( "The field " + fieldName + " should be dirty on first instantiation.", primitivesModel.fields.isDirty(fieldName) ); 
			}
			
			// Test model dirty
			assertTrue( "The field model should be dirty on first instantiation.", primitivesModel.fields.isDirty() ); 						
		}
	}
}
