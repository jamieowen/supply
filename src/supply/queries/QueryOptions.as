package supply.queries {
	/**
	 * @author jamieowen
	 */
	public class QueryOptions
	{
		public var all:Boolean;
		public var first:uint;
		public var last:uint;
		public var sliceStart:uint;
		public var sliceCount:uint;
		
		public function QueryOptions(all:Boolean = true, first:uint = 0, last:uint = 0, sliceStart:uint = 0, sliceCount:uint = 0 )
		{ 
			this.all 		= all;
			this.first 		= first;
			this.last 		= last;
			this.sliceStart = sliceStart;
			this.sliceCount = sliceCount;
		}
	}
}
