package tests.models {
	import mock.models.SignalsTestModel;

	import org.hamcrest.assertThat;
	import org.hamcrest.core.throws;
	/**
	 * @author jamieowen
	 */
	public class SignalsTest
	{

		[Test]
		public function test_dispatch_onSave():void
		{
			var model:SignalsTestModel = new SignalsTestModel();
			var listener:Function = function():void{
				throw new SignalDispatchedPseudoError();	
			};
			model.onSave.add( listener );
			
			assertThat( "Signal not dispatched. ", model.save, throws(SignalDispatchedPseudoError) );
		}
		
		[Test]
		public function test_dispatch_onUpdate():void
		{
			var model:SignalsTestModel = new SignalsTestModel();
			var listener:Function = function():void{
				throw new SignalDispatchedPseudoError();	
			};
			model.onUpdate.add( listener );
			
			assertThat( "Signal not dispatched. ", model.save, throws(SignalDispatchedPseudoError) );
		}
		
		[Test]
		public function test_dispatch_onDestroy():void
		{
			var model:SignalsTestModel = new SignalsTestModel();
			var listener:Function = function():void{
				throw new SignalDispatchedPseudoError();	
			};
			model.onDestroy.add( listener );
			
			assertThat( "Signal not dispatched. ", model.destroy, throws(SignalDispatchedPseudoError) );
		}
		
	}
}

class SignalDispatchedPseudoError extends Error{}
