package supply.errors {
	/**
	 * @author jamieowen
	 */
	public class StorageError extends Error {
		public function StorageError(message : * = "", id : * = 0) {
			super(message, id);
		}
	}
}
