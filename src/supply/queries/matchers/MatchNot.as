package supply.queries.matchers {
	import supply.queries.matchers.IMatcher;
	import supply.api.IModel;

	/**
	 * @author jamieowen
	 */
	public class MatchNot implements IMatcher
	{
		private var _matcher:IMatcher;
		
		public function MatchNot( matcher:IMatcher )
		{
			_matcher = matcher;
		}
		
		public function match(object : IModel) : Boolean {
			return !_matcher.match( object );
		}

		public function clone() : IMatcher
		{
			return new MatchNot(_matcher);
		}
	}
}
