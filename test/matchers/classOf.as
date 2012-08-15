package matchers {
	import org.hamcrest.Matcher;

	public function classOf(type:Class):Matcher
    {
        return new ClassOfMatcher(type);
    }
}
