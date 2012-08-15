package supply.queries.matchers {
	import supply.queries.matchers.IMatcher;
	import supply.api.IModel;

	/**
	 * @author jamieowen
	 */
	public class MatchAnything implements IMatcher
	{
		
		public function MatchAnything()
		{
		}
		
		public function match(object : IModel) : Boolean {
			return true;
		}

		public function clone() : IMatcher {
			return new MatchAnything();
		}
	}
}
