package supply.serialization.object {
	import supply.serialization.ISerializerData;

	/**
	 * @author jamieowen
	 */
	public class ObjectSerializerData implements ISerializerData
	{
		private var _data:Object;
		
		public function ObjectSerializerData(data:Object=null)
		{
			_data = data == null ? {} : data;
		}
		
		public function get data() : *{
			return _data;
		}

		public function set data(data : *) : void{
			_data = data;
		}
	}
}
