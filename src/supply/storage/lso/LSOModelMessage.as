package supply.storage.lso {
	import supply.api.IModel;
	import supply.storage.request.RequestMessage;

	/**
	 * @author jamieowen
	 */
	public class LSOModelMessage implements RequestMessage
	{
		public var model:IModel;
		
		public function LSOModelMessage( model:IModel )
		{
			this.model = model;
		}
	}
}
