package supply.api
{
	import supply.core.Fields;
	import org.osflash.signals.ISignal;

	public interface IModel
	{
		function get onSave():ISignal;
		function get onDelete():ISignal;
		function get onSync():ISignal;
		
		function get cuid():String;
		function save():void;
		function del():void;
		function sync():void;
		function get fields():Fields;
	}
}
