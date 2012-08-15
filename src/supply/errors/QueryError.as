package supply.errors {
	/**
	 * @author jamieowen
	 */
	public class QueryError extends Error {
		public function QueryError(message : * = "", id : * = 0) {
			super(message, id);
		}
	}
}
