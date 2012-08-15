package supply.queries.matchers {
	import supply.queries.matchers.IMatcher;

	/**
	 * @author jamieowen
	 */
	public interface ICompositeMatcher extends IMatcher
	{
		function get matches():Vector.<IMatcher>;
	}
}
