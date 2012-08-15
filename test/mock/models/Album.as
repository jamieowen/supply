package mock.models {
	import supply.base.Model;

	/**
	 * @author jamieowen
	 */
	public class Album extends Model
	{
		public var name:String;
		public var author:Photographer;
		public var photos:Vector.<Photo>;
		
		public function Album()
		{
			super();
		}
	}
}
