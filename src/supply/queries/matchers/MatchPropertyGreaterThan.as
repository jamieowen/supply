package supply.queries.matchers {
	import supply.api.IModel;
	import supply.queries.matchers.MatchPropertyBase;

	/**
	 * @author jamieowen
	 */
	public class MatchPropertyGreaterThan extends MatchPropertyBase
	{
		public function MatchPropertyGreaterThan(property : String, value : * = null) {
			super(property, value);
		}

		override public function match( model:IModel ):Boolean
		{
			if( ( model as Object ).hasOwnProperty(property) )
			{
				if( model[property] is Date && value is Date ){
					var d1:Date = model[property];
					var d2:Date = value;
					
					return d1.time > d2.time;
				}else
					return model[property] > value;
			}else
				return false;
		}

		override public function clone():IMatcher
		{
			return new MatchPropertyGreaterThan(property,value);
		}
	}
}
