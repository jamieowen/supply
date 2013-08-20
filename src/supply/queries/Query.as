package supply.queries {
	import supply.Supply;
	import supply.api.ICollection;
	import supply.core.ns.supply_internal;
	import supply.queries.matchers.CompositeMatchAllOf;
	import supply.queries.matchers.IMatcher;
	import supply.queries.matchers.MatchAnything;
	import supply.queries.matchers.MatchPropertyEquals;
	import supply.queries.matchers.MatchPropertyGreaterThan;
	import supply.queries.matchers.MatchPropertyLessThan;
	
	use namespace supply_internal;
	
	/**
	 * @author jamieowen
	 */
	public class Query
	{
		private var _storage:String;
		private var _model:Class;
		private var _matches:Vector.<IMatcher>;
		
		// options
		private var _queryAll:Boolean;
		private var _start:uint;
		private var _end:uint;
		private var _querySlice:Boolean;
		
		public function Query( model:Class, storage:String )
		{
			_model 		= model;
			_storage 	= storage;
			_matches 	= new Vector.<IMatcher>();
			
			_querySlice = _queryAll = false;
			_start = _end = 0;
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
		supply_internal function get matcher():IMatcher
		{
			if( _matches.length == 1){
				return _matches[0];
			}else
			if( _matches.length > 1 ){
				return new CompositeMatchAllOf(_matches); // recursive filter().values().filter.values() calls are AND'd together.
			}else{
				return null;
			}
		}

		public function filter(...properties ) : QueryFilter {
			// matchers are appended to this Query by the IQueryValues object
			var matchers:Vector.<IMatcher> = parsePropertiesToMatchers.apply(this,properties);
			var filter:QueryFilter = new QueryFilter(this,matchers);
			return filter;
		}

		public function exclude(...properties ) : QueryFilter {
			// matchers are appended to this Query by the IQueryValues object
			// pass in the NotMatch flag with this Query.
			var matchers:Vector.<IMatcher> = parsePropertiesToMatchers.apply(this,properties);
			var filter:QueryFilter = new QueryFilter(this,matchers,true);
			return filter;
		}
		
		public function all():ICollection
		{
			if( _matches.length == 0 ){
				appendMatch( new MatchAnything() );
			}
			_queryAll = true;
			return Supply(_model).executeQuery(_storage, this);
		}
		
		public function first(count:int):ICollection
		{
			if( _matches.length == 0 ){
				appendMatch( new MatchAnything() );
			}
			_start = count;
			return Supply(_model).executeQuery(_storage, this);
		}
		
		public function last(count:int):ICollection
		{
			if( _matches.length == 0 ){
				appendMatch( new MatchAnything() );
			}
			_end = count;
			return Supply(_model).executeQuery(_storage, this);
		}
		
		public function slice(start:int,count:int):ICollection
		{
			if( _matches.length == 0 ){
				appendMatch( new MatchAnything() );
			}
			_querySlice = true;
			_start = start;
			_end = start + count;
			
			return Supply(_model).executeQuery(_storage, this);
		}
	
		/**
		 * Converts supplied properties to matcher objects.
		 */
		protected function parsePropertiesToMatchers( ...properties ) : Vector.<IMatcher>
		{
			var property:String;
			var matcher:IMatcher;
			const matchers:Vector.<IMatcher> = new Vector.<IMatcher>();
			
			const LT_MATCH:RegExp = new RegExp("^.*__lt$");
			const GT_MATCH:RegExp = new RegExp("^.*__gt$");
			
			for each( property in properties )
			{
				if( property ){
					if( property.search( LT_MATCH ) == 0 ){
						matcher = new MatchPropertyLessThan( property.replace(new RegExp("__lt$"), "") );
					}else
					if( property.search( GT_MATCH ) == 0 ){
						matcher = new MatchPropertyGreaterThan( property.replace(new RegExp("__gt$"), "") );
					}else{
						matcher = new MatchPropertyEquals(property);
					}
					
					matchers.push(matcher);
				}else{
					throw new Error("Problem with query. Properties must all be of type String." );
				}
			}
			
			return matchers;
		}
			
		public function dispose():void
		{
			_matches = null;
			_model 	 = null;
		}
	}
}
