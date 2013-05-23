package supply.queries {
	import supply.api.IQuery;
	//import supply.api.IQueryValues;
	import supply.api.IStorage;
	import supply.core.ns.supply_internal;
	import supply.queries.matchers.IMatcher;
	import supply.queries.matchers.MatchAnything;
	import supply.queries.matchers.MatchMapFunction;
	
	use namespace supply_internal;
	
	/**
	 * @author jamieowen
	 */
	public class Query implements IQuery
	{
		private var _storage:IStorage;
		private var _model:Class;
		private var _matches:Vector.<IMatcher>;
		
		public function Query( model:Class, storage:IStorage )
		{
			_model 		= model;
			_storage 	= storage;
			_matches 	= new Vector.<IMatcher>();
		}
		
		supply_internal function appendMatch(match : IMatcher) : void
		{
			_matches.push( match );
		}

		supply_internal function get matches():Vector.<IMatcher>
		{
			return _matches;
		}
		
		/**
		 * Return the matches as single matcher.
		 */
		/**supply_internals function get matcher():IMatcher
		{
			if( _matches.length == 1){
				return _matches[0];
			}else
			if( _matches.length > 1 ){
				return new MatchAllOf(_matches); // recursive filter().values().filter.values() calls are AND'd together.
			}else{
				return null;
			}
		}**/

		/**public function filter(...properties ) : IQueryValues {
			// matchers are appended to this Query by the IQueryValues object
			var matchers:Vector.<IMatcher> = parsePropertiesToMatchers.apply(this,properties);
			var values:QueryValues = new QueryValues(this,matchers);
			return values;
		}

		public function exclude(...properties ) : IQueryValues {
			// matchers are appended to this Query by the IQueryValues object
			// pass in the NotMatch flag with this Query.
			var matchers:Vector.<IMatcher> = parsePropertiesToMatchers.apply(this,properties);
			var values:QueryValues = new QueryValues(this,matchers,true);
			return values;
		}

		public function map(func : Function) : IQuery {
			appendMatch( new MatchMapFunction(func) );
			return this;
		}
		
		public function all():QuerySet
		{
			if( _matches.length == 0 ){
				appendMatch( new MatchAnything() );
			}
			return _storage.query(this, new QueryOptions() );
		}
		
		public function first(count:int):QuerySet
		{
			if( _matches.length == 0 ){
				appendMatch( new MatchAnything() );
			}
			return _storage.query(this, new QueryOptions(false,count) );
		}
		
		public function last(count:int):QuerySet
		{
			if( _matches.length == 0 ){
				appendMatch( new MatchAnything() );
			}
			return _storage.query( this, new QueryOptions(false,0,count) );
		}
		
		public function slice(start:int,count:int):QuerySet
		{
			if( _matches.length == 0 ){
				appendMatch( new MatchAnything() );
			}
			return _storage.query( this, new QueryOptions(false,0,0,start,count) );
		}
		
		public function dispose():void
		{
			_matches = null;
			_model 	 = null;
		}**/
	}
}
