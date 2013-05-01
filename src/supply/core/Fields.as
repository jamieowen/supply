package supply.core {
	import supply.core.reflect.ReflectedField;
	import supply.core.reflect.ReflectedModel;
	import flash.utils.getQualifiedClassName;
	import supply.api.IModelField;
	import supply.Supply;
	import supply.api.IModel;

	import supply.core.ns.supply_internal;

	use namespace supply_internal;
	
	public class Fields
	{

		
		// ---------------------------------------------------------------
		// >> PRIVATE VARIABLES
		// ---------------------------------------------------------------	
				
		private var _model:IModel;
		private var _syncValues:Object;
		
		// ---------------------------------------------------------------
		// >> PUBLIC GETTERS
		// ---------------------------------------------------------------	
		
		public function get numFields():uint
		{
			return Supply().modelsManager.reflect(_model).fieldNames.length;
		}
		
		public function get fieldNames():Array
		{
			return Supply().modelsManager.reflect(_model).fieldNames;
		}
		
						
		// ---------------------------------------------------------------
		// >> CONSTRUCTOR
		// ---------------------------------------------------------------	
				
		public function Fields(model:IModel)
		{
			if( model == null ){
				throw new Error("A Fields instance must have a specified Model instance.");
			}
			_model = model;
			_syncValues = {};
			
			// TODO : could defer this.
			populateSyncValues();
		}
		
		// ---------------------------------------------------------------
		// >> PUBLIC METHODS
		// ---------------------------------------------------------------			
		
		/**
		 * 
		 */
		public function getFieldNameAt(index:uint):String
		{
			return Supply().modelsManager.reflect(_model).fieldNames[index];
		}
		
		/**
		 * Returns the value a field at the time of last sync.
		 */
		public function getSyncValue(fieldName:String):*
		{
			return _syncValues[fieldName];
		}
		
		/**
		 * 
		 */
		private function setSyncValue(fieldName:String,value:*):void
		{
			_syncValues[fieldName] = value;
		}
		
		/**
		 * Tests if the field is dirty and is different from the value at the time of last sync.
		 * If no field is specified then all fields are tested to check if the IModel instance is dirty.
		 */
		public function isDirty(fieldName:String = null ):Boolean
		{
			var dirty:Boolean = false;
			var reflectedModel:ReflectedModel = Supply().modelsManager.reflect(_model);
			var fieldHandler:IModelField;
			var field:ReflectedField;
			var syncValue:*;
			
			if( fieldName == null ){
				var fields:Array = fieldNames;

				for( var i:int = 0; i<fields.length; i++ ){
					fieldName = fields[i];
					field = reflectedModel.getField(fieldName);
					fieldHandler = field.fieldHandler;
					syncValue = getSyncValue(fieldName);
					
					dirty = !( (syncValue == null ) && ( fieldHandler.isEqual( syncValue, getSerializedValue( fieldName ), field.type ) ) );
					 
					if( dirty ){
						break;
					}
				}
			}else{
				field = reflectedModel.getField(fieldName);
				
				if( !field )
					return false;
				
				syncValue = getSyncValue(fieldName);
				fieldHandler = field.fieldHandler;
				
				dirty = !( (syncValue == null ) && ( fieldHandler.isEqual( syncValue, getSerializedValue( fieldName ), field.type ) ) );
			}
			
			return dirty; 
		}
		
		/**
		 * Returns the value of the field after serialization by the IModelField handler.
		 */
		public function getSerializedValue( fieldName:String ):*
		{
			var reflectedModel:ReflectedModel = Supply().modelsManager.reflect(_model);
			var field:ReflectedField = reflectedModel.getField(fieldName);
			
			var fieldHandler:IModelField = reflectedModel.getFieldHandler(fieldName);
			var fieldType:String = field.type;
			
			if( fieldHandler ){
				return fieldHandler.toObject( _model[fieldName], fieldType );	
			}else{
				Supply().warn( "The field, " + fieldName + " of IModel, + " + getQualifiedClassName(_model) + " could not be serialized. Define and register a custom IModelField handler if this is a custom field type." );
				return null;
			}
		}
		
		/**
		 * Returns the value of the field as it stands in the IModel presently.
		 * Same as accessing the field property directly.
		 */
		public function getValue(fieldName:String ):*
		{
			return _model[fieldName];
		}
		
		/**
		 * Serializes the IModel instance to a typed Object.
		 */
		public function toObject():Object
		{
			var fieldNames:Array = fieldNames;
			var field:String;
			var serialized:Object = {};
			for( var i:int = 0; i<fieldNames.length; i++ )
			{
				field = fieldNames[i];
				serialized[field] = getSerializedValue(field);
			}
			
			return serialized;
		}
		
		/**
		 * Populates the IModel instance by deserializing a typed Object.
		 * Also populates the sync values with the last received serialized values.
		 * Serialized values are used for sync values as it's easier to test equality on 
		 * lower level typed objects rather than custom deserialized types.
		 */
		public function fromObject(serialized:Object):void
		{
			var fieldNames:Array = fieldNames;
			var fieldName:String;
			var fieldHandler:IModelField;
			var deserializedValue:*;
			var serializedValue:*;
			
			var reflectedModel:ReflectedModel = Supply().modelsManager.reflect(_model);
			var field:ReflectedField;
			var fieldType:String;
			
			for( var i:int = 0; i<fieldNames.length; i++ )
			{
				fieldName = fieldNames[i];
				field = reflectedModel.getField(fieldName);
				fieldHandler = field.fieldHandler;
				fieldType = field.type;
				
				serializedValue = serialized[fieldName];
				setSyncValue(fieldName, serializedValue);
				
				deserializedValue = fieldHandler.fromObject(serializedValue, fieldType);
				_model[fieldName] = deserializedValue;
			}
		}
		
		
		// ---------------------------------------------------------------
		// >> PRIVATE METHODS
		// ---------------------------------------------------------------
		
		private function populateSyncValues():void
		{
			var fieldNames:Array = fieldNames;
			var fieldName:String;
			for( var i:int = 0; i<fieldNames.length; i++ )
			{
				fieldName = fieldNames[i];
				setSyncValue(fieldName, null );	
			}
		}
		
	}
}

