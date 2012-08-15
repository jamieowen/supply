package supply.core {
	import supply.api.IQuery;

	/**
	 * Shorthand access to the default SupplyContext.
	 * The method provides the top Query object for the Model Class specified
	 * 
	 * @author jamieowen
	 */
	public function Supply(model:Class) : IQuery
	{
		var context:SupplyContext = SupplyContext.getInstance();
		return context.objects(model);
	}
}
