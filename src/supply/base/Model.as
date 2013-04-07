package supply.base {
	import supply.core.uuid;
	import org.osflash.signals.Signal;
	import supply.api.IModel;

	import org.osflash.signals.ISignal;

	public class Model implements IModel
	{
		// ---------------------------------------------------------------
		// >> SIGNAL DECLARATIONS
		// ---------------------------------------------------------------
				
		private var _onSave:ISignal;
		private var _onDelete:ISignal;
		private var _onSync:ISignal;
		
		// ---------------------------------------------------------------
		// >>INTERNAL DECLARATIONS
		// ---------------------------------------------------------------		
		private var _cuid:String;
		
		
		// ---------------------------------------------------------------
		// >> SIGNAL GETTERS
		// ---------------------------------------------------------------
		
		/**
		 * 
		 */
		[Supply(store=false)]
		public function get onSave() : ISignal
		{
			return _onSave;
		}
		
		[Supply(store=false)]
		public function get onDelete() : ISignal
		{
			return _onDelete;
		}
		
		[Supply(store=false)]
		public function get onSync():ISignal
		{
			return _onSync;
		}
		
		// ---------------------------------------------------------------
		// >> INTERNAL DECLARATION GETTERS
		// ---------------------------------------------------------------		
		
		public function get cuid():String
		{
			if( !_cuid ) 			 
			 _cuid = uuid();

			return _cuid;
		}
		
		// ---------------------------------------------------------------
		// >> CONSTRUCTOR
		// ---------------------------------------------------------------	
				
		public function Model()
		{
			 _onSave = new Signal(IModel);
			 _onDelete = new Signal(IModel);
			 _onSync = new Signal(IModel);
		}
		
		// ---------------------------------------------------------------
		// >> MODEL OPERATIONS.
		// ---------------------------------------------------------------	
				
		public function save() : void
		{
			
		}

		public function del() : void
		{
			
		}
		
		public function sync():void
		{
			
		}
		
		// ---------------------------------------------------------------
		// >> MODEL HELPERS. 
		// ---------------------------------------------------------------
		
		
		public function get fields():*
		{
			// Returns a Fields object.

			// a list of properties ( fields )
			// of the model.
			// rather than 
			// model.fields.length:uint
			// model.fields.fieldNameAt(index):String
			// model.fields.syncValue("property"):* // value at the time of last synced.
			// model.fields.dirty("fieldName"):Boolean
			// model.fields.dirty():Boolean // if any fields are dirty
			// model.fields.value("property"):* // current value now.
			// model.fields.toObject():Object
			// model.fields.toString():String ? required
			// model.fields.toBinary():ByteArray ? required
			// model.fields.fromObject("property",object):void; // sets the value of the model property from an object
			// model.fields.fromString("property",string):void; ? required
			// model.fields.fromBinary("property",binary):void; ? required
			// model.fields.getRelations("property"):void; // fetches the relations of the given property
			// model.fields.getRelations():void; // get relations of all relational fields.
			
			// Internally some of these operations are mapped to single instances of
			// ModelField classes which handle the operation and return the result.
			
			// e.g.
			// IntField
			// UIntField
			// StringField
			// ArrayField
			// VectorField			
			// BooleanField
			// NumberField
			// DateField
			// RelationalField // will allow access of a relational fields id, via model.fields.value("relationalProperty"):* // the id of the relational field.
			
			// ModelField
			// maps these functions to their subclasses
			// staticFieldOfTypeInstance.toObject()
			// staticFieldOfTypeInstance.fromObject()
			// 
			// To extend the functionality and support saving of other types
			// the user can register them in the Supply main access function.
			// Supply().registerFieldTypes( DateRangeField, XMLField, CustomFieldType ):void; // etc 
			// These have to implement an interface and handle the operations internally.
			
			
		}
		
		
		public function validation():*
		{
			// different release...
			// later...			
		}
	}
}
