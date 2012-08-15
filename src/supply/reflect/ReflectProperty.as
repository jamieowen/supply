package supply.reflect {
	/**
	 * @author jamieowen
	 */
	public class ReflectProperty
	{		
		public var name:String;
		public var type:String;
		public var store:Boolean;
		public var readonly:Boolean;
		
		public function ReflectProperty():void
		{
			
		}
		
		public function toString():String
		{
			return "[ModelProperty(name='" + name + "', readonly='" + readonly + "', store='" + store + "', type='" + type + "' )]";
		}
	}
}
