package supply.queries {
	import org.osflash.signals.Signal;
	import supply.api.IModel;
	import supply.core.ns.supply_internal;
	/**
	 * @author jamieowen
	 */
	public class QuerySet
	{
		public var onResult:Signal	 = new Signal(QuerySet);
		public var onError:Signal	 = new Signal(QuerySet);
		
		private var _items:Vector.<IModel>;
		private var _query:Query;
		private var _options:QueryOptions;
		
		public function get query():Query
		{
			return _query;
		}
		
		public function get options():QueryOptions
		{
			return _options;
		}
		
		public function get items():Vector.<IModel>
		{
			return _items;
		}

		supply_internal function updateItems( items:Vector.<IModel>):void
		{
			_items = items;
			onResult.dispatch(this);
		}
		
		public function QuerySet(query:Query, options:QueryOptions)
		{
			_items 		= null;
			_query 		= query;
			_options 	= options;
		}
		
		public function dispose():void
		{
			onError.removeAll();
			onResult.removeAll();
			if( _items ) 
				_items.splice(0,uint.MAX_VALUE);
			_items = null;
			_query = null;
			_options = null;
		}
		
	}
}
