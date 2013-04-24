package supply
{
	import supply.core.SupplyMain;
	import supply.core.ns.supply_internal;

	use namespace supply_internal;
	/**
	 * Shorthand access to the default SupplyContext.
	 * The method provides the top Query object for the Model Class specified
	 * 
	 * @author jamieowen
	 */
	public function Supply(model:Class) : SupplyMain {
		var main : SupplyMain = SupplyMain.getInstance();
		main.setOperatingModelClass(model);
		return main;
	}
}
