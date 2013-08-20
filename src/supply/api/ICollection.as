package supply.api {
	import supply.queries.Query;
	/**
	 * @author jamieowen
	 */
	public interface ICollection
	{
		/**
		 * The query that was executed to construct this collection.
		 */
		function get query():Query;
		
		/**
		 * Refresh the collection by running the query again.
		 */
		function refresh():void;
		
		/**
		 * Adds a model to the collection.
		 */
		function add(model:IModel):void;
		
		/**
		 * Removes a model at the specified index.
		 */
		function removeItemAt( index:uint ):IModel;
		
		/**
		 * Returns the model at the specified index.
		 */
		function getItemAt( index:uint ):IModel;
		
		/**
		 * Returns the index
		 */
		function getItemIndex( model:IModel ):uint;
		
		/**
		 * Returns the length of the collection.
		 */
		function get count():uint;
	}
}
