package supply.queries
{
	import supply.errors.QueryError;
	import supply.queries.matchers.IMatcher;
	import supply.queries.matchers.MatchAllOf;
	import supply.queries.matchers.MatchAnyOf;
	import supply.queries.matchers.MatchNot;
	import supply.api.IQuery;
	import supply.api.IQueryValues;
	import supply.queries.matchers.MatchPropertyBase;

	import supply.core.supply_internals;
	
	use namespace supply_internals;
	
	/**
	 * Enables the filter().values() syntax with queries.
	 * Captures the values and 
	 * @author jamieowen
	 */
	public class QueryValues implements IQueryValues
	{
		private var _query:Query;
		private var _matchers:Vector.<IMatcher>; // the property matchers on the filter() or exlclude() methods
		private var _notWrapper:Boolean;
		
		public function QueryValues(query:Query, matchers:Vector.<IMatcher>, notWrapper:Boolean = false )
		{
			_query = query;
			_matchers = matchers;
			_notWrapper = notWrapper;	
		}
		
		/**
		 * 
		 * The basic rules are :
		 * 
		 * If the same number of properties as values are specified then the model is queried with a logical AND on those properties.
		 * e.g.
		 * filter( "firstName", "lastName" ).values( "Jamie", "Owen" )
		 * : would return all objects with firstName=="Jamie" && lastName == "Owen"
		 * 
		 * If multiple properties exist and one value the model is queried with an logical AND on both properties. 
		 * e.g.
		 * filter( "firstName", "lastName" ).values("Owen")
		 * : would return all objects with firstName=="Jamie" && lastName == "Owen"
		 * 
		 * However, if one property is specified with multiple values, the values a logical OR is used.
		 * e.g.
		 * filter( "firstName" ).values( "Jamie", "Bob", "Fred" )
		 * : would return any items with firstName=="Jamie" || firstName=="Bob" || firstName=="Fred"
		 *
		 */
		public function values(...values) : IQuery
		{
			if( values.length == 0 || _matchers.length == 0 ){
				return _query;
			}
			
			var matcher:IMatcher;
			var i:int;
			
			// parse the values and append the matches
			// to the Query object.
			if( _matchers.length == values.length )
			{
				// AND all properties and values.
				// filter( "firstName", "lastName" ).values( "Jamie", "Owen" )
				// firstName=="Jamie" && lastName == "Owen"
				for ( i = 0; i<values.length; i++ ){
					matcher = _matchers[i] as MatchPropertyBase;
					if( matcher ){
						( matcher as MatchPropertyBase ).value = values[i];
					}else
						throw new QueryError("Query values can only operate with MatchPropertyBase objects.");
				}
				
				// append to query set below.
				matcher = new MatchAllOf(_matchers);
				
			}else
			if( values.length == 1 ){
				// use the same value for each matcher with AND
				// filter( "firstName", "lastName" ).values("Owen")
				// would match : firstName=="Jamie" && lastName == "Owen"
				for( i = 0; i<_matchers.length; i++ ){
					matcher = _matchers[i] as MatchPropertyBase;
					if( matcher ){
						( matcher as MatchPropertyBase ).value = values[0];
					}else
						throw new QueryError("Query values can only operate with MatchPropertyBase objects.");
				}
				
				// append to query set below.
				matcher = new MatchAllOf(_matchers);

			}else
			if( _matchers.length == 1 ){
				// duplicate the property matcher with each value, use OR
				// filter( "firstName" ).values( "Jamie", "Bob", "Fred" )
				// would match : firstName=="Jamie" || firstName=="Bob" || firstName=="Fred"
				if( _matchers[0] is MatchPropertyBase){
					for ( i = 0; i<values.length; i++ ){
						if( i > 0 ) {
							// clone the first matcher as we are applying to each specified value.
							matcher = _matchers[0].clone() as MatchPropertyBase; 
							_matchers.push( matcher );
						}else
							matcher = _matchers[0];
						( matcher as MatchPropertyBase ).value = values[i];
					}
				}else
					throw new QueryError("Query values can only operate with MatchPropertyBase objects.");
				
				// append to query set below.
				matcher = new MatchAnyOf(_matchers);
				
			}else
				throw new QueryError("Wrong number of Query arguments specified." );
			
			// append the matcher to the query.
			if( _notWrapper ){
				_query.appendMatch( new MatchNot( matcher ) );
			}else					
				_query.appendMatch( matcher );
			
			return _query;
		}
	}
}
