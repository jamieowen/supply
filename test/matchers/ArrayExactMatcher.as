package matchers {
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
				
				var match:Boolean = true;
				var matcher:ArrayExactMatcher;
				for( var i:int = 0; i<a.length; i++ )	
				{
					if( a[i] is Array )
					{
						matcher = new ArrayExactMatcher(_items[i]);
						match = match && matcher.matches(a[i]);
					}else{
						match = match && ( a[i] == _items[i] );
					}
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
