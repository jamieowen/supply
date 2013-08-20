package supply.queries.matchers
{
	import supply.api.IModel;
	/**
	 * @author jamieowen
	 */
	public class CompositeMatchAnyOf implements ICompositeMatcher
	{
		private var _matches:Vector.<IMatcher>;
		
		public function CompositeMatchAnyOf( matches:Vector.<IMatcher> )
		{
			_matches 			= matches;
		}
		
		public function get matches():Vector.<IMatcher>
		{
			return _matches;
		}
		
		public function match( model:IModel ):Boolean
		{
			var result:Boolean = false;
			for each( var match:IMatcher in _matches ){
				result = result || match.match(model);
			}
			return result;
		}

		public function clone():IMatcher
		{
			return new CompositeMatchAnyOf(_matches);
		}
	}
}
