package supply.fields {
	import supply.api.IModelField;

	/**
	 * @author jamieowen
	 */
	public class ArrayField implements IModelField {
		public function getType() : String {
			return "Array";
		}

		public function toObject() : * {
			
		}

		public function fromObject(obj : *) : void {
		}
	}
}
