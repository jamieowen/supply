package supply.storage.lso {
	import supply.core.SupplyContext;
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
		
		[Inject]
		public var context:SupplyContext;
		
		public function LSOCreateRequest()
		{
			super();
		}
		
		override public function execute():void
		{
			onStart.dispatch(this);
			
			var model:IModel = message.model;
			model.id = uuid();
				
			const name:String = modelInfo.uniqueName;
			const shared:SharedObject = SharedObject.getLocal(context.name);
			const item:* = serializer.serialize(model);
				
			var items:Array;
			if( shared.data[ name ] ){
				items = shared.data[name];
				items.push( item );
			}else{
				items = [item];
				shared.data[name] = items;
			}
			
			onComplete.dispatch(this);
		}
	}
}
