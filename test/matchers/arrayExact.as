package matchers {
	import org.hamcrest.Matcher;
	
	/**
	 * Shorthand hamcrest function style of the ArrayExactMatcher.
	 * 
	 * @author jamieowen
	 */
	public function arrayExact(items:Array) : Matcher
	{
		return new ArrayExactMatcher(items);
	}
}
