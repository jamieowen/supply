package mock.models {
	import supply.Model;

	public class PrimitivesOnlyTestModel extends Model
	{
		private static function getUnicode():String
		{
			var rangeStart:int = 0;
			var rangeEnd:int = 255;
			var unicode:String = "";
			for( var i:int = rangeStart; i<=rangeEnd; i++ ){
				unicode+=String.fromCharCode(i);
			}
			return unicode;
		}
		
		public static const BOOLEAN_VALUE:Boolean = false;
		public static const INT_VALUE:int = 12345678;
		public static const UINT_VALUE:uint = -12345678;
		public static const NUMBER_VALUE:Number = 3.141592654;
		public static const STRING_VALUE:String = getUnicode();
		public static const DATE_VALUE:Date = new Date(12345678);
		public static const XML_VALUE:XML = new XML("<?xml version='1.0' encoding='utf-8'?><root><child1><item/><item/></child1><child2><item/><item/></child2></root>"); 
		public static const ARRAY_VALUE:Array = [BOOLEAN_VALUE,INT_VALUE,UINT_VALUE,NUMBER_VALUE,STRING_VALUE,DATE_VALUE,XML_VALUE];
		public static const ARRAYMULTI_VALUE:Array = ARRAY_VALUE.concat( ARRAY_VALUE, ARRAY_VALUE, ARRAY_VALUE.concat(ARRAY_VALUE) );

		public var booleanField:Boolean = BOOLEAN_VALUE;
		public var intField:int = INT_VALUE;
		public var uintField:uint = UINT_VALUE; 
		public var numberField:Number = NUMBER_VALUE; 
		public var stringField:String = STRING_VALUE;
		public var dateField:Date = DATE_VALUE;
		public var xmlField:XML = XML_VALUE;
		public var arrayField:Array = ARRAY_VALUE;
		public var arrayMultiField:Array = ARRAYMULTI_VALUE;
		 
		public var vectorBooleanField:Vector.<Boolean> = new Vector.<Boolean>( [BOOLEAN_VALUE, BOOLEAN_VALUE, BOOLEAN_VALUE] );
		public var vectorIntField:Vector.<int> = new Vector.<int>( [INT_VALUE, INT_VALUE, INT_VALUE, INT_VALUE] );
		public var vectorUIntField:Vector.<uint> = new Vector.<uint>( [UINT_VALUE, UINT_VALUE, UINT_VALUE, UINT_VALUE] );
		public var vectorNumberField:Vector.<Number> = new Vector.<Number>( [NUMBER_VALUE, NUMBER_VALUE, NUMBER_VALUE, NUMBER_VALUE] );
		public var vectorStringField:Vector.<String> = new Vector.<String>( [STRING_VALUE, STRING_VALUE, STRING_VALUE, STRING_VALUE] );
		public var vectorDateField:Vector.<Date> = new Vector.<Date>( [DATE_VALUE, DATE_VALUE, DATE_VALUE, DATE_VALUE] );
		public var vectorXMLField:Vector.<XML> = new Vector.<XML>( [XML_VALUE, XML_VALUE, XML_VALUE, XML_VALUE] );
		public var vectorArrayMultiField:Vector.<Array> = new Vector.<Array>( [ARRAYMULTI_VALUE,ARRAYMULTI_VALUE,ARRAYMULTI_VALUE,ARRAYMULTI_VALUE] );
		
		public function PrimitivesOnlyTestModel()
		{
			super();
		}
	}
}
