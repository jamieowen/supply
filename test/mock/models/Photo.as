package mock.models {
	import supply.serialization.JSONSerializer;
	import supply.api.ISerializer;
	import supply.storage.LocalSharedObjectStorage;
	import supply.api.IStorage;
	import supply.base.Model;

	/**
	 * @author jamieowen
	 */
	public class Photo extends Model
	{
		//public static const storage:IStorage 			 = new LocalSharedObjectStorage();
		//public static const serialization:ISerialization = new JSONSerialization();
		
		public var title:String;
		public var author:Photographer;
		public var tags:Vector.<Tag>;
		public var published:Date;
		public var lens:int;
		public var focalRatio:Number;
		
		public function Photo()
		{
			super();
		}
		
		public function toString():String
		{
			return "[ Photo( title :" + title + 
							", author :" + author + 
							", lens :" + lens + 
							", published :" + published + 
							", focalRatio:" + focalRatio + ") ]";
		}
	}
}
