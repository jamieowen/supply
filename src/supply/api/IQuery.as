package supply.api {
	import supply.queries.QuerySet;
	/**
	 * @author jamieowen
	 */
	public interface IQuery
	{
		/**function filter(...models):IQuery;
		function exclude( ...models ):IQuery;
		function map( func:Function ):IQuery;
		
		function all():QuerySet;
		function first(count:int):QuerySet;
		function last(count:int):QuerySet;
		function slice(start:int,count:int):QuerySet;**/
	}
}
