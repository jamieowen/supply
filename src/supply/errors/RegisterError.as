package supply.errors {
	/**
	 * @author jamieowen
	 */
	public class RegisterError extends Error {
		public function RegisterError(message : * = "", id : * = 0) {
			super(message, id);
		}
	}
}
