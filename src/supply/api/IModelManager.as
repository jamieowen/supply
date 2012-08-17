package supply.api {
	import org.osflash.signals.ISignal;
	/**
	 * @author jamieowen
	 */
	public interface IModelManager
	{
		// pre-action signals
		function get onCreate():ISignal;
		function get onUpdate():ISignal;
		function get onDestroy():ISignal;
		
		// post-action signals ( after storage )
		function get onCreated():ISignal;
		function get onUpdated():ISignal;
		function get onDestroyed():ISignal;
				
		function get query():IQuery;
		function create( model:IModel ):void;
		function update( model:IModel ):void;
		function destroy( model:IModel ):void;
	}
}
