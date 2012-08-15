package supply.errors {
	/**
	 * @author jamieowen
	 */
	public class SingletonError extends Error {
		public function SingletonError(message : * = "", id : * = 0) {
			super(message, id);
		}
	}
}
