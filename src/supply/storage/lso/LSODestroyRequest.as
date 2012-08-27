package supply.storage.lso {
	import supply.api.IModel;
	import flash.net.SharedObject;
	import supply.core.SupplyContext;
	import supply.core.ContextModelData;
	import supply.api.ISerializer;
	import supply.storage.request.RequestBase;

	/**
	 * @author jamieowen
	 */
	public class LSODestroyRequest extends RequestBase
	{
		[Inject]
		public var serializer:ISerializer;
		
		[Inject]
		public var message:LSOModelMessage;
		
		[Inject]
		public var modelInfo:ContextModelData;
		
		[Inject]
		public var context:SupplyContext;
		
		public function LSODestroyRequest()
		{
			super();
		}

		override public function execute():void
		{
			onStart.dispatch(this);
			
			const name:String = modelInfo.uniqueName;
			const shared:SharedObject = SharedObject.getLocal(context.name);
			
			// fetch all items in local storage.
			var items:Array;
			if( shared.data[ name ] ){
				items = shared.data[name];
			}else{
				items = [];
			}
			
			// slow implementation for now - should just look up id in objects direct from the SharedObject, but this prevents changing serialization methods.
			// this might not be required though.
			
			// deserialize all items.
			var all:Vector.<IModel> = serializer.deserializeMany(items);
			
			for( var i:int = 0; i<all.length; i++ )
			{
				if( all[i].id === message.model.id ){
					all.splice(i,1);
					break;
				}
			}
			
			items = serializer.serializeMany(all);
			shared.data[name] = items;
			
			onComplete.dispatch(this);
		}
		
	}
}
