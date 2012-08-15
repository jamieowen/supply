package supply.queries.matchers
{
	import supply.api.IModel;
	/**
	 * @author jamieowen
	 */
	public class MatchPropertyBase implements IMatcher
	{
		private var _property:String;
		private var _value:*;
		
		public function MatchPropertyBase( property:String, value:* = null )
		{
			_property = property;
			_value	  = value;
		}
		
		public function get property():String
		{
			return _property;
		}
		
		public function get value():*
		{
			return _value;
		}
		
		public function set value(value:*):void
		{
			_value = value;
		}
		
		public function match( model:IModel ):Boolean
		{
			return false;
		}
		
		public function clone():IMatcher
		{
			throw new Error( "clone() attempted on MatchPropertyBase abstract class.");
		}
	}
}
