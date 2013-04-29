package tests.models
{
	import supply.fields.DateField;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	import supply.api.IModel;

	import matchers.arrayExact;

	import mock.models.PrimitivesOnlyTestModel;

	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertTrue;
	import org.hamcrest.assertThat;
	
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
				if( value is Boolean || value is int || value is uint || value is String || value is Number ){
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
						assertThat( "The field '" + fieldName + "' did not serialize correctly.", [PrimitivesOnlyTestModel.BOOLEAN_VALUE,PrimitivesOnlyTestModel.INT_VALUE,PrimitivesOnlyTestModel.UINT_VALUE,PrimitivesOnlyTestModel.NUMBER_VALUE,PrimitivesOnlyTestModel.STRING_VALUE,PrimitivesOnlyTestModel.DATE_VALUE,PrimitivesOnlyTestModel.XML_VALUE], arrayExact( fieldValue as Array ) );
						break;
					case "arrayMultiField":
						assertThat( "The field '" + fieldName + "' did not serialize correctly.", [PrimitivesOnlyTestModel.ARRAYMULTI_VALUE,PrimitivesOnlyTestModel.ARRAYMULTI_VALUE,PrimitivesOnlyTestModel.ARRAYMULTI_VALUE,PrimitivesOnlyTestModel.ARRAYMULTI_VALUE ], arrayExact( fieldValue as Array ) );
						break;
					case "vectorBooleanField":
						assertThat( "The field '" + fieldName + "' did not serialize correctly.", [PrimitivesOnlyTestModel.BOOLEAN_VALUE,PrimitivesOnlyTestModel.BOOLEAN_VALUE,PrimitivesOnlyTestModel.BOOLEAN_VALUE,PrimitivesOnlyTestModel.BOOLEAN_VALUE], arrayExact( fieldValue as Array ) );
						break;
					case "vectorIntField":
						assertThat( "The field '" + fieldName + "' did not serialize correctly.", [PrimitivesOnlyTestModel.INT_VALUE,PrimitivesOnlyTestModel.INT_VALUE,PrimitivesOnlyTestModel.INT_VALUE,PrimitivesOnlyTestModel.INT_VALUE], arrayExact( fieldValue as Array ) );		
						break;
					case "vectorUIntField":
						assertThat( "The field '" + fieldName + "' did not serialize correctly.", [PrimitivesOnlyTestModel.UINT_VALUE,PrimitivesOnlyTestModel.UINT_VALUE,PrimitivesOnlyTestModel.UINT_VALUE,PrimitivesOnlyTestModel.UINT_VALUE], arrayExact( fieldValue as Array ) );
						break;
					case "vectorNumberField":
						assertThat( "The field '" + fieldName + "' did not serialize correctly.", [PrimitivesOnlyTestModel.NUMBER_VALUE,PrimitivesOnlyTestModel.NUMBER_VALUE,PrimitivesOnlyTestModel.NUMBER_VALUE,PrimitivesOnlyTestModel.NUMBER_VALUE], arrayExact( fieldValue as Array ) );
						break;
					case "vectorStringField":
						assertThat( "The field '" + fieldName + "' did not serialize correctly.", [PrimitivesOnlyTestModel.STRING_VALUE,PrimitivesOnlyTestModel.STRING_VALUE,PrimitivesOnlyTestModel.STRING_VALUE,PrimitivesOnlyTestModel.STRING_VALUE], arrayExact( fieldValue as Array ) );
						break;
					case "vectorDateField":
						assertThat( "The field '" + fieldName + "' did not serialize correctly.", [PrimitivesOnlyTestModel.DATE_VALUE.getTime(),PrimitivesOnlyTestModel.DATE_VALUE.getTime(),PrimitivesOnlyTestModel.DATE_VALUE.getTime(),PrimitivesOnlyTestModel.DATE_VALUE.getTime()], arrayExact( fieldValue as Array ) );
						break;
					case "vectorXMLField":
						assertThat( "The field '" + fieldName + "' did not serialize correctly.", [PrimitivesOnlyTestModel.XML_VALUE.toString(),PrimitivesOnlyTestModel.XML_VALUE.toString(),PrimitivesOnlyTestModel.XML_VALUE.toString(),PrimitivesOnlyTestModel.XML_VALUE.toString() ], arrayExact( fieldValue as Array ) );
						break;
					case "vectorArrayMultiField":
						assertThat( "The field '" + fieldName + "' did not serialize correctly.", [PrimitivesOnlyTestModel.ARRAYMULTI_VALUE,PrimitivesOnlyTestModel.ARRAYMULTI_VALUE,PrimitivesOnlyTestModel.ARRAYMULTI_VALUE,PrimitivesOnlyTestModel.ARRAYMULTI_VALUE ], arrayExact( fieldValue as Array ) );
						break;
					default :
						assertEquals( "The field '" + fieldName + "' did not serialize correctly.", primitivesModel[fieldName], fieldValue );
				}
			}			
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
			
			trace( "TEST DESERIALIZED" );
			
			var vec:Vector.<IModel> = new Vector.<IModel>();
			var pVec:Vector.<PrimitivesOnlyTestModel> = new Vector.<PrimitivesOnlyTestModel>();
			
			trace( getQualifiedClassName(pVec) );
			trace( getQualifiedClassName(vec) );
			var vecCls:Class = getDefinitionByName( "__AS3__.vec::Vector.<supply.fields::DateField>" ) as Class;
			
			trace( vecCls );
			var dVec:Vector.<DateField> = new vecCls();
			trace( getQualifiedClassName(vecCls));
			trace( getQualifiedClassName(dVec));
			for( var i:int = 0; i<10; i++ )
			{
				dVec.push( new DateField() );
			}
			
			
			trace( "__AS3__.vec::Vector.<DateField>");
			
			
			
			
			
		}
	}
}
