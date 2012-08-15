package mock.models {
	import supply.base.Model;

	use namespace testnamespace;
	/**
	 * @author jamieowen
	 */
	public class ReflectAllModel extends Model
	{
		// public properties.
		public var string_property:String;
		public var number_property:Number;
		public var int_property:int;
		public var uint_property:uint;
		public var date_property:Date;
		public var object_property:Object;
		public var array_property:Array;
		
		public var model_vector:Vector.<ReflectAllModel>;
		
		// no store property
		[Supply(store=false)]
		public var nostore_string_property:String;
		
		// private - shoudn't show up.
		private var private_string_property:String;
		private var private_number_property:Number;
		
		// protected - shouldn't show up
		protected var protected_string_property:String;
		protected var protected_number_property:Number;
		
		// custom namespace - shouldn't show up
		testnamespace var testnamespace_string_property:String;
		testnamespace var testnamespace_number_property:Number;
		
		// readwrite property
		public function get readwrite_string_property():String
		{
			return "";
		}
		
		public function set readwrite_string_property(value:String):void
		{
			
		}
		
		// readonly property.
		public function get readonly_string_property():String
		{
			return "";
		}
		
		
		public function ReflectAllModel()
		{
			super();
		}
	}
}
