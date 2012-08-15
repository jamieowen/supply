package tests.core {
	import flash.display.DisplayObject;
	import org.hamcrest.core.throws;
	import supply.errors.RegisterError;
	import mock.models.Tag;
	import mock.models.Photographer;
	import mock.models.Album;
	import org.hamcrest.object.isTrue;
	import org.hamcrest.object.isFalse;
	import org.hamcrest.assertThat;
	import mock.models.Photo;
	import supply.core.SupplyContext;
	/**
	 * @author jamieowen
	 */
	public class RegisterTest
	{
		[Test]
		public function test_register_unregister_ModelClassSingle():void
		{
			var context:SupplyContext = SupplyContext.getInstance();
			context.register(Photo);
			assertThat( context.isRegistered(Photo), isTrue() );
			context.unregister(Photo);
			assertThat( context.isRegistered(Photo), isFalse() );
		}

		[Test(expects="supply.errors.RegisterError")]
		public function test_register_unregister_ModelClassSingleFail():void
		{
			var context:SupplyContext = SupplyContext.getInstance();
			context.register(Date);
		}

		[Test]
		public function test_register_unregister_ModelClassMultiple():void
		{
			var context:SupplyContext = SupplyContext.getInstance();
			context.register(Photo,Album,Photographer);
			
			assertThat( context.isRegistered(Photo), isTrue() );
			assertThat( context.isRegistered(Album), isTrue() );
			assertThat( context.isRegistered(Photographer), isTrue() ); 
						
		
			context.unregister(Photo);
			context.unregister(Album);
			context.unregister(Photographer);
			
			assertThat( context.isRegistered(Photo), isFalse() );
			assertThat( context.isRegistered(Album), isFalse() );
			assertThat( context.isRegistered(Photographer), isFalse() ); 
		}
		
		[Test(expects="supply.errors.RegisterError")]
		public function test_register_unregister_ModelClassMultipleFail():void
		{
			var context:SupplyContext = SupplyContext.getInstance();
			context.register(Date, Class, Object, DisplayObject );
		}

		[Test]
		public function test_register_unregisterAll_ModelClassSingle():void
		{
			var context:SupplyContext = SupplyContext.getInstance();
			context.register(Photo);
			assertThat( context.isRegistered(Photo), isTrue() );
			context.unregisterAll();
			assertThat( context.isRegistered(Photo), isFalse() );
		}

		[Test]
		public function test_register_unregisterAll_ModelClassMultiple():void
		{
			var context:SupplyContext = SupplyContext.getInstance();
			context.register(Photo,Album,Photographer);
			
			assertThat( context.isRegistered(Photo), isTrue() );
			assertThat( context.isRegistered(Album), isTrue() );
			assertThat( context.isRegistered(Photographer), isTrue() ); 
						
			context.unregisterAll();
			
			assertThat( context.isRegistered(Photo), isFalse() );
			assertThat( context.isRegistered(Album), isFalse() );
			assertThat( context.isRegistered(Photographer), isFalse() ); 
		}
	}
}
