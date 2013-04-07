package mock.models {
	import supply.base.Model;

	public class PrimitivesOnlyModel extends Model
	{
		public var intField:int;
		public var stringField:String;
		public var uintField:uint;
		public var booleanField:Boolean;
		public var arrayField:Array;
		public var numberField:Number;
		
		public function PrimitivesOnlyModel()
		{
			super();
		}
	}
}
