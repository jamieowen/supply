package mock.models {
	import flash.utils.ByteArray;
	import flash.display.BitmapData;
	/**
	 * @author jamieowen
	 */
	public class LocalStorageItemTest
	{
		public var name:String = "Jamie";
		public var id:uint = 123;
		public var num:Number = 3.141592654;
		public var array:Array = [1,2,3,4,5,6,7];
		public var vector:Vector.<Date> = new Vector.<Date>();
		public var vectorNumber:Vector.<Number> = new Vector.<Number>();
		public var image:BitmapData = new BitmapData(100,100,false,0x00000);
		public var bool:Boolean;
		public var date:Date = new Date( 1982,3,3);
		public var byteArray:ByteArray = new ByteArray();
		
		public function LocalStorageItemTest()
		{
			vector.push( new Date(1982,3,3) );
			vector.push( new Date(1982,3,3) );
			vector.push( new Date(1982,3,3) );
			vector.push( new Date(1982,3,3) );
			
			vectorNumber.push( 10.0 );
			vectorNumber.push( 10.3 );
			vectorNumber.push( 10.4 );
			vectorNumber.push( 10.5 );
			
			byteArray.writeUTFBytes("HELLOTHEREMMYNAMEIS JAMIE");
			
			
		}
		
		public function print():void
		{
			trace( "name " + name );
			trace( "id   " + id );
			trace( "num  " + num );
			trace( "arra " + array );
			trace( "vect " +  vector );
			trace( "vecN " + vectorNumber );
			trace( "imag " + image );
			trace( "bool " + bool );
			trace( "date " +  date );
			trace( "bytes :" + byteArray.toString() );
		}
		
	}
}
