package supply.core.reflect
{
	import supply.api.IModelField;
	
	public class ReflectedField
	{
		public var name:String;
		public var type:String;
		public var fieldHandler:IModelField;
			
		public function ReflectedField():void
		{
				
		}
			
		public function toString():String
		{
			return "[ModelField(name='" + name + "', type='" + type + "' )]";
		}
	}
}
