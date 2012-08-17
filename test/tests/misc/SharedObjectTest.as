package tests.misc {
	import flash.utils.describeType;
	import flash.net.registerClassAlias;
	import mock.models.LocalStorageItemTest;
	import avmplus.getQualifiedClassName;
	import flash.net.SharedObject;
	/**
	 * @author jamieowen
	 */
	public class SharedObjectTest
	{
		[Test]
		public function localStorage():void
		{
			registerClassAlias("LocalStorageItemTest",LocalStorageItemTest);
			
			var local:SharedObject = SharedObject.getLocal("test");
			
	
			var myObject:* = local.data.myObject;
			if( myObject ){
				trace( "LOCAL SHARED EXISTS" );
				//trace( describeType(myObject) );
				trace( getQualifiedClassName(myObject) );
				trace( getQualifiedClassName(myObject.byteArray ) );
				( myObject as LocalStorageItemTest ).print();
				
				
				// increment some values.
				var obj:LocalStorageItemTest = myObject as LocalStorageItemTest;
				
				
				
				obj.id ++;
				obj.array.push( obj.id );
				obj.vector.push( new Date() );
				obj.bool = !obj.bool;
				obj.name = obj.name + "E";
				obj.vectorNumber.push( Math.random() );
				obj.date = new Date();
				obj.byteArray.writeUTFBytes( "HELLO" + obj.id );
				
				
			}else
			{
				trace( "NO LOCAL SHARED OBJECT");
				trace( "Creating...");
				
				var test:LocalStorageItemTest = new LocalStorageItemTest();
				local.data.myObject = test;
				local.flush();
				
			}
			
			
			//local.clear();
		}
	}
}
