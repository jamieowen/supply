package tests.queries {
	import supply.queries.matchers.IMatcher;
	import supply.queries.matchers.MatchPropertyEquals;
	import supply.queries.matchers.MatchPropertyGreaterThan;
	import supply.queries.matchers.MatchPropertyLessThan;

	import org.hamcrest.object.instanceOf;
	import org.hamcrest.object.hasPropertyWithValue;
	import org.hamcrest.assertThat;
	import org.flexunit.asserts.assertEquals;
	import supply.queries.parsePropertiesToMatchers;
	/**
	 * @author jamieowen
	 */
	public class ParsePropertyToMatchersTest
	{
		[Test]
		public function testParseLessThanMatcher():void
		{
			var prop:String = "customProp__lt";
			
			var matches:Vector.<IMatcher> = parsePropertiesToMatchers(prop);
			
			assertEquals( "Too many or too few matches returned.", 1, matches.length );
			assertThat( "Matcher is not LessThanMatcher", matches[0], instanceOf( MatchPropertyLessThan ) );
			assertThat( matches[0], hasPropertyWithValue("property", "customProp") );
		}

		[Test]
		public function testParseGreaterThanMatcher():void
		{
			var prop:String = "customProp__gt";
			
			var matches:Vector.<IMatcher> = parsePropertiesToMatchers(prop);
			
			assertEquals( "Too many or too few matches returned.", 1, matches.length );
			assertThat( "Matcher is not GreaterThanMatcher", matches[0], instanceOf( MatchPropertyGreaterThan ) );
			assertThat( matches[0], hasPropertyWithValue("property", "customProp") );
		}

		[Test]
		public function testParseIncorrectLessThanMatcher():void
		{
			var prop:String = "customProp_lt";
			
			var matches:Vector.<IMatcher> = parsePropertiesToMatchers(prop);
			
			assertEquals( "Too many or too few matches returned.", 1, matches.length );
			assertThat( "Matcher should be MatchPropertyEquals", matches[0], instanceOf( MatchPropertyEquals ) );
			assertThat( matches[0], hasPropertyWithValue("property", "customProp_lt") );
		}

		[Test]
		public function testParseIncorrectGreaterThanMatcher():void
		{
			var prop:String = "customProp_gt";
			
			var matches:Vector.<IMatcher> = parsePropertiesToMatchers(prop);
			
			assertEquals( "Too many or too few matches returned.", 1, matches.length );
			assertThat( "Matcher should be MatchPropertyEquals", matches[0], instanceOf( MatchPropertyEquals ) );
			assertThat( matches[0], hasPropertyWithValue("property", "customProp_gt") );
		}

		[Test]
		public function testParseEqualsMatcher1():void
		{
			var prop:String = "customProp";
			
			var matches:Vector.<IMatcher> = parsePropertiesToMatchers(prop);
			
			assertEquals( "Too many or too few matches returned.", 1, matches.length );
			assertThat( "Matcher should be MatchPropertyEquals", matches[0], instanceOf( MatchPropertyEquals ) );
			assertThat( matches[0], hasPropertyWithValue("property", "customProp") );
		}

		[Test]
		public function testParseEqualsMatcher2():void
		{
			var prop:String = "custom_Prop";
			
			var matches:Vector.<IMatcher> = parsePropertiesToMatchers(prop);
			
			assertEquals( "Too many or too few matches returned.", 1, matches.length );
			assertThat( "Matcher should be MatchPropertyEquals", matches[0], instanceOf( MatchPropertyEquals ) );
			assertThat( matches[0], hasPropertyWithValue("property", "custom_Prop") );
		}

		[Test]
		public function testParseEqualsMatcher3():void
		{
			var prop:String = "__ltcustom_Prop";
			
			var matches:Vector.<IMatcher> = parsePropertiesToMatchers(prop);
			
			assertEquals( "Too many or too few matches returned.", 1, matches.length );
			assertThat( "Matcher should be MatchPropertyEquals", matches[0], instanceOf( MatchPropertyEquals ) );
			assertThat( matches[0], hasPropertyWithValue("property", "__ltcustom_Prop") );
		}
	

		
	}
}
