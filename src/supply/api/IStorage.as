package supply.api {
	import supply.queries.Query;
	/**
	 * @author jamieowen
	 */
	public interface IStorage
	{
		function save(model:IModel):void;
		function del(model:IModel):void;
		function sync(model:IModel):void;
		function query(query:Query):ICollection;
	}
}
