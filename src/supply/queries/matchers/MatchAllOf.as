package supply.queries.matchers {
	import supply.api.IModel;
	/**
	 * @author jamieowen
	 */
	public class MatchAllOf implements ICompositeMatcher
	{
		private var _matches:Vector.<IMatcher>;
		
		public function MatchAllOf( matches:Vector.<IMatcher> )
		{
			_matches 			= matches;
		}
		
		public function get matches():Vector.<IMatcher>
		{
			return _matches;
		}
		
		public function match( model:IModel ):Boolean
		{
			var result:Boolean = true;
			for each( var match:IMatcher in _matches ){
				result = result && match.match(model);
			}
			return result;
		}
		
		public function clone():IMatcher
		{
			return new MatchAllOf(_matches);
		}
	}
}
