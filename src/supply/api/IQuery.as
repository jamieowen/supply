package supply.api {
	/**
	 * @author jamieowen
	 */
	public interface IQuery
	{
		function filter(...properties):IQueryValues;
		function exclude( ...properties ):IQueryValues;
		function map( func:Function ):IQuery;
		
		function all():*;
		function first(count:int):*;
		function last(count:int):*;
		function slice(start:int,count:int):*;
	}
}
