package supply.api {
	import supply.queries.QueryOptions;
	import supply.queries.Query;
	/**
	 * @author jamieowen
	 */
	public interface IStorage
	{
		function query( query:Query, options:QueryOptions ):*;
		function create( model:IModel ):void;
		function update( model:IModel ):void;
		function destroy( model:IModel ):void;
	}
}
