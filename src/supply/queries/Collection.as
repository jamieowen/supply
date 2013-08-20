package supply.queries {
	import supply.Supply;
	import org.osflash.signals.ISignal;
	import supply.api.ICollection;
	import org.osflash.signals.Signal;
	import supply.api.IModel;
	import supply.core.ns.supply_internal;
	
	use namespace supply_internal;
	
	/**
	 * @author jamieowen
	 */
	public class Collection implements ICollection
	{
		public var onResult:ISignal	 = new Signal(ICollection);
		public var onError:ISignal	 = new Signal(ICollection);
		
		private var _items:Vector.<IModel>;
		private var _query:Query;
		
		
		public function get items():Vector.<IModel>
		{
			return _items;
		}

		supply_internal function updateItems( items:Vector.<IModel>):void
		{
			_items = items;
			onResult.dispatch(this);
		}
		
		public function Collection(query:Query)
		{
			_items 		= null;
			_query 		= query;
		}
		
		public function dispose():void
		{
			onError.removeAll();
			onResult.removeAll();
			
			if( _items ) 
				_items.splice(0,uint.MAX_VALUE);
			_items = null;
			_query = null;
		}
		
		/**
		 * The query that was executed to construct this collection.
		 */
		public function get query():Query
		{
			return _query;	
		}
		
		/**
		 * Refresh the collection by running the query again.
		 */
		public function refresh():void
		{
			Supply().executeQuery( query.storage, _query, this );
		}
		
		/**
		 * Adds a model to the collection.
		 * Or this may not be needed - As we need to query again to check this collection matches.
		 */
		public function add(model:IModel):void
		{
			
		}
		
		/**
		 * Removes a model at the specified index.
		 */
		public function removeItemAt( index:uint ):IModel
		{
			
		}
		
		/**
		 * Returns the model at the specified index.
		 */
		public function getItemAt( index:uint ):IModel
		{
			
		}
		
		/**
		 * Returns the index
		 */
		public function getItemIndex( model:IModel ):uint
		{
			
		}
		
		/**
		 * Returns the length of the collection.
		 */
		public function get count():uint
		{		
			
		}
		
	}
}
