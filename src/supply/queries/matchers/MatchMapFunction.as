package supply.queries.matchers {
	import supply.errors.QueryError;
	import supply.queries.matchers.IMatcher;
	import supply.api.IModel;

	/**
	 * @author jamieowen
	 */
	public class MatchMapFunction implements IMatcher
	{
		private var _func:Function;
		
		public function MatchMapFunction(func:Function)
		{ 
			_func = func;
		}
		
		public function match(object : IModel) : Boolean
		{
			try{
				return _func( object );
			}catch( e:Error ){
				throw new QueryError("There was an error with the supplied mapping function." );
			}
			
			return false;
		}
	
		public function clone():IMatcher
		{
			return new MatchMapFunction(_func);
		}
	}
}
