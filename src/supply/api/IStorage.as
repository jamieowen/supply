package supply.api {
	import supply.queries.QueryOptions;
	import supply.queries.Query;
	/**
	 * @author jamieowen
	 */
	public interface IStorage
	{
		function query( query:Query, options:QueryOptions ):*;
		function add( model:IModel ):void;
		function save( model:IModel ):void;
		function destroy( model:IModel ):void;
	}
}
