package supply.errors {
	/**
	 * @author jamieowen
	 */
	public class SerializationError extends Error {
		public function SerializationError(message : * = "", id : * = 0) {
			super(message, id);
		}
	}
}
