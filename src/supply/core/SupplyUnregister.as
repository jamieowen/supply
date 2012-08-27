package supply.core {
	/**
	 * @author jamieowen
	 */
	public function SupplyUnregister(...models) : void{
		var context:SupplyContext = SupplySingleton.getInstance();
		context.unregister.apply(this, models );
	}
}
