package supply.base {
	import supply.core.ModelDelegate;
	import supply.api.IModel;

	import org.osflash.signals.ISignal;

	/**
	 * Base Model for other models to inherit from.
	 * If inheritance can't be used, implement the IModel interface and use the ModelDelegate object
	 * to 
	 * @author jamieowen
	 */
	public class Model implements IModel
	{
		private var _delegate:ModelDelegate;
		
		private var _id:String;
		
		public function get id():String
		{
			return _id;
		}
		
		public function set id(value:String):void
		{
			_id = value;
		}
		
		public function Model()
		{
			_delegate = new ModelDelegate(this);
		}
		
		public function save() : void
		{
			_delegate.save();
		}

		public function destroy() : void
		{
			_delegate.destroy();
		}
		
		[Supply(store=false)]
		public function get onSave() : ISignal
		{
			return _delegate.onSave;
		}
		
		[Supply(store=false)]
		public function get onDestroy() : ISignal
		{
			return _delegate.onDestroy;
		}
		
		[Supply(store=false)]
		public function get onUpdate():ISignal
		{
			return _delegate.onUpdate;
		}
	}
}
