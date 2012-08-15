package supply.queries.matchers {
	import supply.api.IModel;
	/**
	 * @author jamieowen
	 */
	public interface IMatcher
	{
		function match( object:IModel ):Boolean;
		function clone():IMatcher;
	}
}
