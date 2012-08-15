package supply.queries.matchers {
	import supply.api.IModel;
	import supply.queries.matchers.MatchPropertyBase;

	/**
	 * @author jamieowen
	 */
	public class MatchPropertyEquals extends MatchPropertyBase
	{
		public function MatchPropertyEquals(property : String, value : * = null) {
			super(property, value);
		}
		
		override public function match( model:IModel ):Boolean
		{
			if( ( model as Object ).hasOwnProperty(property) )
			{
				return model[property] === value;
			}else
				return false;			
		}
		
		override public function clone():IMatcher
		{
			return new MatchPropertyEquals(property,value);
		}
	}
}
