package supply.core
{
	import supply.api.IModel;
	
	/**
	 * @author jamieowen
	 */
	public function modelHasId(model:IModel) : Boolean {
		if( model ){
			if( model.id == null || model.id == "" )
				return false;
			else
				return true;
		}else{
			return false;
		}
	}
}
