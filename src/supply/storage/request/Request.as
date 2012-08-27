package supply.storage.request {
	import org.osflash.signals.ISignal;
	/**
	 * @author jamieowen
	 */
	public interface Request
	{
		function get onStart():ISignal;
		function get onComplete():ISignal;
		function execute():void;
		function dispose():void;
	}
}
