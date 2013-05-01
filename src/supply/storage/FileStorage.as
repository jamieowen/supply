package supply.storage
{
	import supply.queries.Query;
	import supply.api.ICollection;
	import supply.api.IModel;
	import supply.api.IStorage;
	/**
	 * @author jamieowen
	 */
	public class FileStorage implements IStorage
	{
		public static var name:String = "file";
		
		// ***********************************************
		// > PRIVATE DECLARATIONS
		// ***********************************************
		
		// CONFIG.
		// filePath
		// serialization = json | xml | csv | yaml | binary | etc.
		// cache
		// async
		// 
				
		// ***********************************************
		// > CONSTRUCTOR
		// ***********************************************
		
		public function FileStorage()
		{
			
		}
		
		// ***********************************************
		// > PUBLIC METHODS
		// ***********************************************
				
		public function save(model:IModel):void
		{
			
		}
		
		public function del(model:IModel):void
		{
			
		}
		
		public function sync(model:IModel):void
		{
			
		}
		
		public function query(query:Query):ICollection		
		{
			return null;
		}
	}
}
