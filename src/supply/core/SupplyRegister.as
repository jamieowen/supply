package supply.core {
	/**
	 * @author jamieowen
	 */
	public function SupplyRegister(...models) : void
	{
		var context:SupplyContext = SupplySingleton.getInstance();
		context.register.apply( this, models );
	}
}
