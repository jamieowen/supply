package supply.core.reflect {
	/**
	 * @author jamieowen
	 */
	public class ReflectedModel
	{
		private var _properties:Vector.<ReflectedProperty>;
		private var _storageClass:Class;
		
		public function get properties():Vector.<ReflectedProperty>
		{
			return _properties;
		}
		
		public function get storageClass():Class
		{
			return _storageClass;
		}
		
		public function ReflectedModel(model:Class, properties:Vector.<ReflectedProperty>)
		{
			_properties = properties;
		}
	}
}
