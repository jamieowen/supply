package supply.core {
	import supply.api.IModel;
	import supply.api.IModelManager;
	import supply.api.IQuery;
	import supply.api.ISerializer;
	import supply.api.IStorage;
	import supply.queries.Query;
	import supply.reflect.ReflectModel;

	import org.osflash.signals.ISignal;

	/**
	 * @author jamieowen
	 */
	public class ModelManager implements IModelManager
	{
		private var _onCreate:ISignal;
		private var _onUpdate:ISignal;
		private var _onDestroy:ISignal;

		private var _onCreated:ISignal;
		private var _onUpdated:ISignal;
		private var _onDestroyed:ISignal;
		
		[Inject(name="Signal")]
		public function SignalType(SignalType:Class):void
		{
			_onCreate		= new SignalType(IModel);
			_onUpdate		= new SignalType(IModel);
			_onDestroy		= new SignalType(IModel);

			_onCreated		= new SignalType(IModel);
			_onUpdated		= new SignalType(IModel);
			_onDestroyed	= new SignalType(IModel);
		}

		[Inject(name="Model")]
		public var model:Class;
		
		[Inject]
		public var reflect:ReflectModel;
		
		[Inject]
		public var storage:IStorage;
		
		[Inject]
		public var serializer:ISerializer;
		
		//[Inject]
		//public var queries:IQueryManager;
		
		//[Inject]
		//public var instances:IInstanceManager;
		
		
		public function ModelManager()
		{

		}
		
		public function get onCreate():ISignal
		{
			return _onCreate;
		}
		
		public function get onUpdate():ISignal
		{
			return _onUpdate;
		}
		
		public function get onDestroy():ISignal
		{
			return _onDestroy;
		}

		public function get onCreated():ISignal
		{
			return _onCreated;
		}
		
		public function get onUpdated():ISignal
		{
			return _onUpdated;
		}
		
		public function get onDestroyed():ISignal
		{
			return _onDestroyed;
		}
		
		public function create(model : IModel) : void
		{
			storage.create( model );
		}

		public function update(model : IModel) : void
		{
			storage.update( model );
		}

		public function destroy(model : IModel) : void
		{
			storage.destroy(model);
		}

		public function get query() : IQuery
		{
			return new Query(model, storage);
		}
	}
}