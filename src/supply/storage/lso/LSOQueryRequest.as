package supply.storage.lso {
	import supply.queries.matchers.IMatcher;
	import supply.queries.Query;
	import supply.api.IModel;
	import supply.api.ISerializer;
	import flash.net.SharedObject;
	import supply.core.SupplyContext;
	import supply.core.ContextModelData;
	import supply.storage.request.RequestBase;
	import supply.core.supply_internals;
	
	use namespace supply_internals;
	/**
	 * @author jamieowen
	 */
	public class LSOQueryRequest extends RequestBase
	{
		[Inject]
		public var serializer:ISerializer;
		
		[Inject]
		public var message:LSOQueryMessage;
		
		[Inject]
		public var modelInfo:ContextModelData;
		
		[Inject]
		public var context:SupplyContext;
		
		public function LSOQueryRequest() {
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
			
			// deserialize all items.
			var all:Vector.<IModel> = serializer.deserializeMany(items);
			
			// run matcher on all items
			var resultsFiltered:Vector.<IModel> = all;
			var results:Vector.<IModel>;
			var query:Query = message.querySet.query;
			var match:IMatcher;
			var model:IModel;
			var i:int;
			var m:int;
			
			for( m = 0; m<query.matches.length; m++ )
			{
				match = query.matches[m];
				results = resultsFiltered;
				resultsFiltered = new Vector.<IModel>();
				for( i = 0; i<results.length; i++ ){
					model = results[i];
					if( match.match(model)){
						resultsFiltered.push( model );
					}
				}
			}
			
			message.querySet.updateItems( resultsFiltered );
			
			onComplete.dispatch(this);
		}
	}
}
