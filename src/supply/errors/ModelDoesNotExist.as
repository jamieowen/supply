package supply.errors {
	/**
	 * @author jamieowen
	 */
	public class ModelDoesNotExist extends Error
	{
		public function ModelDoesNotExist(message : * = "", id : * = 0)
		{
			super(message, id);
		}
	}
}
