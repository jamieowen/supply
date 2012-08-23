package supply.core.reflect {
	/**
	 * @author jamieowen
	 */
	public class ReflectedProperty
	{		
		public var name:String;
		public var type:String;
		public var store:Boolean;
		public var readonly:Boolean;
		public var isForeignKey:Boolean; // indicates if the type is a model managed by this context.
		
		public function ReflectedProperty():void
		{
			
		}
		
		public function toString():String
		{
			return "[ModelProperty(name='" + name + "', readonly='" + readonly + "', store='" + store + "', type='" + type + "' )]";
		}
	}
}
