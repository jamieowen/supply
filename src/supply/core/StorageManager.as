package supply.core
{
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
		
		public function StorageManager()
		{
			
		}
		
		public function registerStorage( storage:Class ):Boolean
		{			
			var name:String = storage["name"];
			
			if( name != "" && name != null )
			{
				if( _storageTypes == null ){
					_storageTypes = {};
				}
				
				if( _storageTypes[name] ){
					Supply().warn( "A storage with the name '" + name + "' is already registered. Use a different name." );
					return false;
				}else{
					_storageTypes[name] = storage;
					return true;
				}
			}else{
				Supply().warn( "Specify a static 'name' property on custom storage classes." );
				return false;
			}
		}
		
		public function registerStorages( ...storages ):Boolean
		{
			if( storages == null ){
				return;
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
		
		public function createStorageInstance(name:String):IStorage
		{
			var storageClass:Class = _storageTypes[name] as Class;
			
			if( storageClass ){
				var storage:IStorage = new storageClass() as IStorage;
				return storage;
			}else
			{
				Supply().warn( "A Storage class with the name '" + name + "' does not exist." );
			}
		}
	}
}
