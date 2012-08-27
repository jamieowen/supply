package supply.core
{
	import org.osflash.signals.Signal;
	import org.osflash.signals.ISignal;
	import supply.api.IModel;

	// TODO - look into changing interface on ModelDelegate - IModel interface implies this is a Model and can be passed to
	// save functions. Which it is not.
	public class ModelDelegate implements IModel
	{
		// unique id for the model
		private var _uid:String;
		
		private var _id:String;
		
		public function get id():String
		{
			return _id;
		}
		
		public function set id(value:String):void
		{
			_id = value;
		}
		
		// a reference to the user-defined Model object containing properties.
		private var _model:IModel;
		
		// signals.
		private var _onSave:ISignal 		= new Signal(IModel);
		private var _onDestroy:ISignal 		= new Signal(IModel);
		private var _onUpdate:ISignal 		= new Signal(IModel);
		
		public function ModelDelegate( model:IModel )
		{
			_model 	= model;
			_uid 	= uuid();
		}
		
		public function save() : void
		{
			_onSave.dispatch(_model);
			
			_onUpdate.dispatch(_model);
		}

		public function destroy() : void
		{
			_onDestroy.dispatch(_model);
		}

		public function get onSave() : ISignal
		{
			return _onSave;
		}

		public function get onDestroy() : ISignal
		{
			return _onDestroy;
		}
		
		public function get onUpdate():ISignal
		{
			return _onUpdate;
		}
	}
}
