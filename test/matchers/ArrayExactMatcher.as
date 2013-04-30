package matchers {
	import avmplus.getQualifiedClassName;
	import org.hamcrest.Description;
	import org.hamcrest.BaseMatcher;

	/**
	 * A Hamcrest Matcher to match an array's values exactly.
	 * 
	 * @author jamieowen
	 */
	public class ArrayExactMatcher extends BaseMatcher
	{
		private var _items:Array;
		
		public function ArrayExactMatcher(items:Array)
		{
			_items = items == null ? [] : items;
		}
		
		// ========================================
		// Public methods
		// ========================================	

		/**
		 * Matches if the specified Boolean condition evaluates to true
		 */
		override public function matches(item:Object):Boolean
		{
			var a:Array = item as Array;
			if( a )
			{
				if( a.length != _items.length ){
					return false;	
				}
				
				var testObjectsAreEqual:Function = function(obj1:*,obj2:*):Boolean
				{
					var equal:Boolean = true;
					var type1:String = getQualifiedClassName(obj1);
					var type2:String = getQualifiedClassName(obj2);
					var matcher:ArrayExactMatcher;
					
					if( type1 != type2 ){
						equal = false;			
					}else
					if( type1 == "Array" )
					{
						matcher = new ArrayExactMatcher(obj2);
						equal = equal && matcher.matches(obj1);
					}else
					if( type1 == "XML" ){
						equal = (obj1 as XML).toString() == (obj2 as XML).toString();	
					}else
					if( type1 == "Date" ){
						equal = (obj1 as Date).getTime() == (obj2 as Date).getTime();	
					}else
					if( type1 == "Object"){
						var key:String;
						var keyCount1:int = 0;
						var keyCount2:int = 0;
						for each( key in obj1 ){
							keyCount1++;
						}
						for each( key in obj2 ){
							keyCount2++;
						}
						if( keyCount1 != keyCount2 ){
							equal = false;					
						}else{
							for each( key in obj1 ){
								equal = testObjectsAreEqual(obj1[key], obj2[key]);
							}
						}
					}else 
					if( obj1 !== obj2 ) {
						equal = false;
					}
					return equal;
				};
				
				var match:Boolean = true;
				for( var i:int = 0; i<a.length; i++ )	
				{
					match = testObjectsAreEqual(a[i], _items[i]);
					if( !match )
						break;
				}
				return match;
			}else
			{
				return false;
			}
		}

		/**
		 * @inheritDoc
		 */
		override public function describeTo( description:Description ):void
		{
			description.appendText("an array with exactly the same values. ")
				.appendValue( _items );
		}
	}
}
