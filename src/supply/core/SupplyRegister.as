package supply.core {
	/**
	 * @author jamieowen
	 */
	public function SupplyRegister(...models) : void
	{
		var context:SupplyContext = SupplyContext.getInstance();
		context.register.apply( this, models );
	}
}
