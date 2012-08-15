package mock.models {
	import supply.base.Model;

	/**
	 * @author jamieowen
	 */
	public class Photographer extends Model
	{
		public var firstName:String;
		public var lastName:String;
		public var email:String;
		public var dob:Date;
		public var isAmateur:Boolean;
		
		public function Photographer( firstName:String = "" )
		{
			super();
			
			this.firstName = firstName;
		}
		
		public function toString():String
		{
			return "[Photographer(firstName="  + firstName + ")]";
		}
	}
}
