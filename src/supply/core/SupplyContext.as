package supply.core
{
	import supply.queries.QueryOptions;
	import supply.queries.Query;
	import supply.api.IQuery;
	import avmplus.getQualifiedClassName;
	import supply.api.IModel;
	import supply.errors.ModelDoesNotExist;
	import supply.errors.RegisterError;
	import supply.errors.SingletonError;
	import supply.reflect.isModelClass;
	
	
	
	/**
	 * @author jamieowen
	 */
	public class SupplyContext
	{
		// ==--
		// Initialise as a singleton for now and have only one context.
		// may look at having multiple contexts later.
		// having a singleton access allows for a nicer shorthand syntax Supply(Class).filter()... 
		// and one less step by removing the need to add( ) a model instance to the context. 
		// This way you just create a model then call model.save()
		
		// One option would be to have multiple contexts which operate with only save()
		// by default. But if a Model class is registered and detected in multiple Contexts,
		// calling save() without adding manually would throw an error.
		
		private static var _instance:SupplyContext;
		private static var _allowCreate:Boolean = false;
		public static function getInstance():SupplyContext
		{
			if( !_instance ){
				_allowCreate = true;
				_instance = new SupplyContext();
				_allowCreate = false;	
			}
			return _instance;
		}
		// ==--
		
		private var _models:Vector.<Class>;
		
		/**
		 * @param id A unique id to use for this Supply instance if more than one are used in an app.
		 */
		public function SupplyContext()
		{
			// singleton test
			if( !_allowCreate ) throw new SingletonError("There can be only one SupplyContext for now! Use SupplyContext.getInstance()");
			
			_models = new Vector.<Class>();
		}
		
		/**
		 * Registers an <code>IModel</code> class.
		 * 
		 * @param cls The <code>IModel</code> class(s) to register.

		 */
		public function register(...cls):void
		{
			var c:Class;
			// validate
			for each( c in cls ){
				if ( !isModelClass(c) ) {
					throw new RegisterError( "Registered models must implement the " + getQualifiedClassName(IModel) + " interface. No models registered." );
				}
			}
			// register
			for each( c in cls ){
				if( !isRegistered(c) ){
					_models.push(c);
				}				
			}
		}
		
		/**
		 * Determines if the IModel is already registered.
		 * @param cls The Imo
		 */
		public function isRegistered( cls:Class ):Boolean
		{
			for each( var model:Class in _models ){
				if( model == cls ) return true;
			}
			return false;
		}
		
		/**
		 * Starts a query on a model. 
		 */
		public function objects( model:Class ):IQuery {
			if( isRegistered(model) ){
				return new Query(model,null);
			}else{
				throw new ModelDoesNotExist("The Model is not registered. Register the model first before querying.");
			}
		}
		
		/**
		 * 
		 */
		public function add( model:IModel ):void
		{
			
		}
		
		supply_internals function executeQuery( query:Query, options:QueryOptions ):void
		{
			
		}

	}
}
