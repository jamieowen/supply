 package supply.storage
{
	import supply.storage.serializers.JSONSerializer;
	import supply.core.reflect.ReflectedModel;
	import flash.utils.ByteArray;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.filesystem.File;
	import supply.Supply;
	import supply.queries.Query;
	import supply.api.ICollection;
	import supply.api.IModel;
	import supply.api.IStorage;
	import supply.storage.serializers.ISerializer;
	
	
	import supply.core.ns.supply_internal;
	use namespace supply_internal;	
	/**
	 * @author jamieowen
	 */
	public class FileStorage implements IStorage
	{
		// ***********************************************
		// > STATIC PUBLIC DECLARATIONS
		// ***********************************************
		
		public static var name:String = "file";
		
		// ***********************************************
		// > STATIC PUBLIC METHODS
		// ***********************************************
		private static var __serializers:Object;
		
		private static function get _serializers():Object
		{
			if( __serializers == null ){	
				__serializers = {};
				registerSerializer(new JSONSerializer());
			}
			
			return __serializers;
		}
		
		public static function registerSerializer(serializer:ISerializer):Boolean
		{
			if( _serializers[ serializer.name ] )
			{
				Supply.warn( "A Serializer with the name '" + name + "' is already registered."); 
				return false;
			}else{
				_serializers[ serializer.name ] = serializer;
				return true;
			}
		}
		
		public static function getSerializer(name:String):ISerializer
		{	
			var serializer:ISerializer = _serializers[name];
			if( serializer ){	
				return serializer;
			}else{
				Supply.warn( "A Serializer with the name '" + name + "' does not exist.");
				return null;
			}
		}
		
		// ***********************************************
		// > PRIVATE DECLARATIONS
		// ***********************************************
		
		private var _reflected:ReflectedModel;
		private var _data:Object;
		private var _actionQueue:Vector.<Object>;
		private var _currentAction:Object;
		
		
		// ***********************************************
		// > PRIVATE GETTERS ( CONFIG VARS )
		// ***********************************************		
		
		private function get file():String
		{				
			if( _reflected.storageConfig["file"] == null ){
				_reflected.storageConfig["file"] = _reflected.className.toLowerCase() + "." + serialization; 
			}
			return _reflected.storageConfig["file"];
		}
		
		private function get serialization():String
		{
			if( _reflected.storageConfig["serialization"] == null ){
				_reflected.storageConfig["serialization"] = "json";
			}
			return _reflected.storageConfig["serialization"];
		}
		
		private function get async():Boolean
		{
			if( _reflected.storageConfig["async"] == null ){
				_reflected.storageConfig["async"] = false;
			}
			return _reflected.storageConfig["async"];
		}
		
		private function get cache():Boolean
		{
			if( _reflected.storageConfig["cache"] == null ){
				_reflected.storageConfig["cache"] = false;
			}			
			return _reflected.storageConfig["cache"];
		}
		
		// ***********************************************
		// > CONSTRUCTOR
		// ***********************************************
		
		public function FileStorage(reflected:ReflectedModel)
		{
			_reflected = reflected;
			
			trace( "File Storage : " + reflected.msid );
		}
		
		// ***********************************************
		// > PUBLIC METHODS
		// ***********************************************
				
		public function save(model:IModel):void
		{
			var action:Function = function( data:Object, next:Function, model:IModel ):void
			{
				// TODO : This is not necessary - as the cuid can only be set internally.
				var obj:Object;
				// check for existence of model already.
				var found:int = -1;
				var models:Array = data["models"];
				for( var i:int = 0; i<models.length; i++ )
				{
					obj = models[i];
					if( model.cuid == obj["cuid"] ){
						found = i;
						break;
					}
				}
				if( found > -1){
					models[found] = model.fields.toObject(); 
				}else{
					models.push( model.fields.toObject() );
				}
				
				next();
			};
			
			queueAction("save", action, [model]);
		}
		
		public function del(model:IModel):void
		{
			
		}
		
		public function sync(model:IModel):void
		{
			
		}
		
		public function query(query:Query):ICollection		
		{
			return null;
		}
		
		// ***********************************************
		// > PRIVATE METHODS
		// ***********************************************
		
		private function queueAction( name:String, action:Function, args:Array ):void
		{
			if( _actionQueue == null ){
				_actionQueue = new Vector.<Object>();
			}
			
			_actionQueue.push( {name:name, action:action, args:args } );
			
			if( _currentAction == null ){
				processActions();
			}
		}
		
		private function processActions():void
		{
			if( _data == null ){
				loadData();
				return;	
			}
			
			if( _actionQueue.length )
			{
				_currentAction = _actionQueue.shift();
				var defaultArgs:Array = [_data,processActions];
				var actionArgs:Array = _currentAction["args"] as Array; 
				if( actionArgs ){
					defaultArgs =  defaultArgs.concat( actionArgs );
				}
				trace( "File Storage (processAction) : " + _currentAction.name );
				
				var action:Function = _currentAction["action"] as Function;
				action.apply(this, defaultArgs);
				
			}else{
				_currentAction = null;
				saveData();
			}
		}
		
		private function loadData():void
		{ 
			if( async )	{
				trace( "Async..");
			}else{
				var serializer:ISerializer = getSerializer(serialization);
				if( serializer == null){
					return;
				}
								
				var read:File = File.applicationStorageDirectory.resolvePath(file);
				if( read.exists )
				{
					var stream:FileStream = new FileStream();
					stream.open( read, FileMode.READ );
					var serialized:String = stream.readUTFBytes( stream.bytesAvailable );
					stream.close();
					_data = serializer.deserialize( serialized );
					
					processActions();
				}else
				{
					_data = {};
					_data["type"] = _reflected.type; //model type
					_data["msid"] = _reflected.msid; //model schema version ( for migrations )
					_data["models"] = []; // items.
					
					processActions();
				}
			}
		}
		
		private function saveData():void
		{
			if( async ){
				
			}else{
				var serializer:ISerializer = getSerializer(serialization);
				if( serializer == null){
					return;
				}
				if( _data == null ){
					Supply.warn( "(FileStorage) No data to be written."); 
					return;
				}
				var serialized:* = serializer.serialize(_data);
				trace( "Writing Data : " + serialized + " " );
				trace( "To path : " + File.applicationStorageDirectory.nativePath );
				var write:File = File.applicationStorageDirectory.resolvePath(file);
				var stream:FileStream = new FileStream();
				stream.open(write, FileMode.WRITE);
				if( serialized is String ){
					stream.writeUTFBytes(serialized);
				}else
				if( serialized is ByteArray ){
					stream.writeBytes(serialized);
				}
				stream.close();
			}
		}
	}
}
