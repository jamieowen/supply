package supply.storage.lso {
	import flash.net.SharedObject;
	import supply.core.uuid;
	import supply.api.IModel;
	import supply.core.ContextModelData;
	import supply.api.ISerializer;
	import supply.storage.request.RequestBase;

	/**
	 * @author jamieowen
	 */
	public class LSOCreateRequest extends RequestBase
	{
		[Inject]
		public var serializer:ISerializer;
		
		[Inject]
		public var modelInfo:ContextModelData;
		
		[Inject]
		public var message:LSOModelMessage;
		
		public function LSOCreateRequest()
		{
			super();
		}
		
		override public function execute():void
		{
			onStart.dispatch();
			
			var model:IModel = message.model;
			model.id = uuid();
				
			const name:String = modelInfo.name;
			const shared:SharedObject = SharedObject.getLocal("Supply"); // Name should be replaced with context name.
			const item:* = serializer.serialize(model);
				
			var items:Array;
			if( shared.data[ name ] ){
				items = shared.data[name];
				items.push( item );
			}else{
				items = [item];
				shared.data[name] = items;
			}
			
			onComplete.dispatch();
		}
	}
}
