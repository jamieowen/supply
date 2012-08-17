package supply.core {
	/**
	 * @author jamieowen
	 */
	public class SupplySingleton
	{
		private static var _instance:SupplyContext;
		
		public static function getInstance():SupplyContext
		{
			if( !_instance ){
				_instance = new SupplyContext();
			}
			return _instance;
		}
	}
}
