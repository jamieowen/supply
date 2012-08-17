package tests.core {
	import supply.api.IModelManager;
	import mock.models.Photographer;
	import mock.models.Album;
	import mock.models.Photo;
	import supply.core.SupplyContext;
	/**
	 * @author jamieowen
	 */
	public class InjectionTest
	{
		[Test]
		public function test():void
		{
			var context:SupplyContext = new SupplyContext();
			context.register( Photo, Album, Photographer );
			var manager:IModelManager = context.objects( Photo );
			
			
			
		}
	}
}
