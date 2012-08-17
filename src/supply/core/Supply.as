package supply.core {
	import supply.api.IModelManager;

	/**
	 * Shorthand access to the default SupplyContext.
	 * The method provides the top Query object for the Model Class specified
	 * 
	 * @author jamieowen
	 */
	public function Supply(model:Class) : IModelManager
	{
		var context:SupplyContext = SupplySingleton.getInstance();
		return context.objects(model);
	}
}
