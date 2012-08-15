package supply.reflect {
	/**
	 * @author jamieowen
	 */
	public class ReflectModel
	{
		private var _properties:Vector.<ReflectProperty>;
		private var _storageClass:Class;
		
		public function get properties():Vector.<ReflectProperty>
		{
			return _properties;
		}
		
		public function get storageClass():Class
		{
			return _storageClass;
		}
		
		public function ReflectModel(model:Class)
		{
			_properties = reflectPropertiesFromModelClass(model);
			
			
			
		}
	}
}
