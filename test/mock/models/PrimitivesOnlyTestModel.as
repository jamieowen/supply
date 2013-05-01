package mock.models {
	import supply.Model;

	[Supply( storage="file", serialization="json", async=true, cache=true )]
	public class PrimitivesOnlyTestModel extends Model
	{
		private static function getUnicode():String
		{
			var rangeStart:int = 32;
			var rangeEnd:int = 126;
			var unicode:String = "";
			for( var i:int = rangeStart; i<=rangeEnd; i++ ){
				unicode+=String.fromCharCode(i);
			}
			return unicode;
		}
		
		/**
		 * Populates a vector with the items. For some reason passing an array to the vector contructor is not working.
		 */
		public static function populateVector(vector:*, items:Array ):*
		{
			for( var i:int = 0; i<items.length; i++ )
			{
				vector.push( items[i] );
			}
			return vector;
		}
		
		public static const BOOLEAN_VALUE:Boolean = false;
		public static const INT_VALUE:int = -12345678;
		public static const UINT_VALUE:uint = 12345678;
		public static const NUMBER_VALUE:Number = 3.141592654;
		public static const STRING_VALUE:String = getUnicode();
		public static const DATE_VALUE:Date = new Date(12345678);
		public static const XML_VALUE:XML = new XML("<?xml version='1.0' encoding='utf-8'?><root><child1><item/><item/></child1><child2><item/><item/></child2></root>"); 
		public static const ARRAY_VALUE:Array = [BOOLEAN_VALUE,INT_VALUE,UINT_VALUE,NUMBER_VALUE,STRING_VALUE,DATE_VALUE,XML_VALUE];
		public static const ARRAYMULTI_VALUE:Array = [ ARRAY_VALUE, ARRAY_VALUE, ARRAY_VALUE, ARRAY_VALUE ];
		
		public var booleanField:Boolean;
		public var intField:int;
		public var uintField:uint; 
		public var numberField:Number; 
		public var stringField:String;
		public var dateField:Date;
		public var xmlField:XML;
		public var arrayField:Array;
		public var arrayMultiField:Array;
		 
		public var vectorBooleanField:Vector.<Boolean>; 
		public var vectorIntField:Vector.<int>; 
		public var vectorUIntField:Vector.<uint>; 
		public var vectorNumberField:Vector.<Number>; 
		public var vectorStringField:Vector.<String>; 
		public var vectorDateField:Vector.<Date>; 
		public var vectorXMLField:Vector.<XML>; 
		public var vectorArrayMultiField:Vector.<Array>; 
		
		/**
		 * Will populate the test model with default values to test serialization.
		 */
		public function populateDefaults():void
		{
			booleanField = BOOLEAN_VALUE;
			intField = INT_VALUE;
			uintField = UINT_VALUE;
			numberField = NUMBER_VALUE;
			stringField = STRING_VALUE;
			dateField = DATE_VALUE;
			xmlField = XML_VALUE;
			arrayField = ARRAY_VALUE;
			arrayMultiField = [ARRAYMULTI_VALUE, ARRAYMULTI_VALUE, ARRAYMULTI_VALUE, ARRAYMULTI_VALUE];
			
			vectorBooleanField = populateVector( new Vector.<Boolean>(), [BOOLEAN_VALUE, BOOLEAN_VALUE, BOOLEAN_VALUE, BOOLEAN_VALUE] );
			vectorIntField = populateVector( new Vector.<int>(), [INT_VALUE, INT_VALUE, INT_VALUE, INT_VALUE] );
			vectorUIntField = populateVector( new Vector.<uint>(), [UINT_VALUE, UINT_VALUE, UINT_VALUE, UINT_VALUE] );
			vectorNumberField = populateVector( new Vector.<Number>(), [NUMBER_VALUE, NUMBER_VALUE, NUMBER_VALUE, NUMBER_VALUE] );
			vectorStringField = populateVector( new Vector.<String>(), [STRING_VALUE, STRING_VALUE, STRING_VALUE, STRING_VALUE] );
			vectorDateField = populateVector( new Vector.<Date>(), [DATE_VALUE, DATE_VALUE, DATE_VALUE, DATE_VALUE] );
			vectorXMLField = populateVector( new Vector.<XML>(), [XML_VALUE, XML_VALUE, XML_VALUE, XML_VALUE] );
			vectorArrayMultiField = populateVector( new Vector.<Array>(), [ARRAYMULTI_VALUE, ARRAYMULTI_VALUE, ARRAYMULTI_VALUE, ARRAYMULTI_VALUE] );
		}
		
		public function PrimitivesOnlyTestModel()
		{
			super();
		}
	}
}
