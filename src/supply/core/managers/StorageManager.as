package supply.core.managers
{
	import supply.api.IModel;
	import supply.core.reflect.ReflectedModel;
	import flash.utils.Dictionary;
	import supply.api.IStorage;
	import supply.Supply;
	import supply.core.ns.supply_internal;
	
	use namespace supply_internal;
	
	/**
	 * @author jamieowen
	 */
	public class StorageManager
	{
		private var _storageTypes:Object;
		private var _storageInstances:Dictionary;
		
		public function StorageManager()
		{
			
		}
		
		public function registerStorage( storage:Class ):Boolean
		{	
			if( storage == null ){
				return false;		
			}
			var name:String = storage["name"];
			
			if( name != "" && name != null )
			{
				if( _storageTypes == null ){
					_storageTypes = {};
				}
				
				if( _storageTypes[name] ){
					Supply.warn( "A storage with the name '" + name + "' is already registered. Use a different name." );
					return false;
				}else{
					_storageTypes[name] = storage;
					return true;
				}
			}else{
				Supply.warn( "Specify a static 'name' property on custom storage classes." );
				return false;
			}
		}
		
		public function registerStorages( ...storages ):Boolean
		{
			if( storages == null ){
				return false;
			}
			
			var storage:Class;
			var success:Boolean = true;
			for( var i:int = 0; i<storages.length; i++ )
			{
				storage = storages[i] as Class;
				if( storage ){
					success = success && registerStorage( storage );
				}
			}
			
			return success;
		}
		
		private function getStorageByReflectedModel(reflected:ReflectedModel):IStorage
		{
			var storage:IStorage = _storageInstances[reflected]; 
			if( storage ){
				return storage;
			}
			
			if( _storageTypes == null ){
				_storageTypes = {};	
			}
			
			if( _storageInstances == null ){
				_storageInstances = new Dictionary();
			}
			
			const name:String = reflected.storageConfig["storage"];			
			const storageClass:Class = _storageTypes[name] as Class;
			
			if( storageClass ){
				storage = new storageClass(reflected) as IStorage;
				_storageInstances[reflected] = storage;	
				return storage;
			}else
			{
				Supply.warn( "A Storage class with the name '" + name + "' does not exist." );
				return null;
			}
		}
		
		public function getStorageByInstance( model:IModel ):IStorage
		{
			const reflected:ReflectedModel = Supply.modelsManager.reflect(model);
			return getStorageByReflectedModel(reflected);
		}
		
		public function getStorageByClass( model:Class ):IStorage
		{
			const reflected:ReflectedModel = Supply.modelsManager.reflectModelClass(model);
			return getStorageByReflectedModel(reflected);
		}
	}
}
