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
		
		private function createStorageInstance(reflected:ReflectedModel):IStorage
		{
			if( _storageTypes == null ){
				_storageTypes = {};	
			}
			var name:String = reflected.storageConfig["storage"];			
			var storageClass:Class = _storageTypes[name] as Class;
			
			if( storageClass ){
				var storage:IStorage = new storageClass(reflected) as IStorage;
				return storage;
			}else
			{
				Supply.warn( "A Storage class with the name '" + name + "' does not exist." );
				return null;
			}
		}
		
		public function getStorage( model:IModel ):IStorage
		{
			var reflected:ReflectedModel = Supply.modelsManager.reflect(model);
			
			if( _storageInstances == null ){
				_storageInstances = new Dictionary();
			}
			
			var storage:IStorage = _storageInstances[reflected]; 
			if( storage == null ){
				storage = createStorageInstance( reflected );
				_storageInstances[reflected] = storage;		
			}
			
			return storage;
		}
	}
}
