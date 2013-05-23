package supply.queries {
	import supply.queries.matchers.MatchPropertyGreaterThan;
	import supply.queries.matchers.MatchPropertyLessThan;
	import supply.queries.matchers.MatchPropertyEquals;
	import supply.queries.matchers.IMatcher;
	
	/**
	 * @author jamieowen
	 */
	public function parsePropertiesToMatchers( ...properties ) : Vector.<IMatcher>
	{
		var property:String;
		var matcher:IMatcher;
		var matchers:Vector.<IMatcher> = new Vector.<IMatcher>();
		
		var LT_MATCH:RegExp = new RegExp("^.*__lt$");
		var GT_MATCH:RegExp = new RegExp("^.*__gt$");
		
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
}
