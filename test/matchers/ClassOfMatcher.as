package matchers {
	import org.hamcrest.BaseMatcher;

	import flash.utils.describeType;

	/**
	 * @author jamieowen
	 */
	public class ClassOfMatcher extends BaseMatcher
	{
		private var _factoryType:String;
		
		public function ClassOfMatcher(type:Class)
		{
			_factoryType = describeType(type).factory.@type;
		}
		
		override public function matches(item : Object) : Boolean
		{
			var desc:XML = describeType(item);
			
			var match:Boolean = desc.factory.@type == _factoryType;
			var type:XML;
			if( !match )
			{
				for each( type in desc.factory.implementsInterface )
				{
					if( type.@type == _factoryType )
						match = true;
				}
			}
			
			if( !match )
			{
				for each( type in desc.factory.extendsClass )
				{
					if( type.@type == _factoryType )
						match = true;
				}				
			}
			
			return match;
		}
	}
}
