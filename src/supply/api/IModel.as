package supply.api {
	import org.osflash.signals.ISignal;
	/**
	 * @author jamieowen
	 */
	public interface IModel
	{
		function save():void;
		function destroy():void;
		
		function get onSave():ISignal;
		function get onDestroy():ISignal;
		function get onUpdate():ISignal;
	}
}
