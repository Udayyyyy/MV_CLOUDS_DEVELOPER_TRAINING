global class UpdateAccNameBatch implements database.batchable<sObject> {
    
    global database.querylocator start(database.batchablecontext bc){
        
        return database.getquerylocator([select name, account.name from opportunity where accountid != null]);
    }
    global void execute(database.batchablecontext bc, list <opportunity> olist){
        
        for(opportunity o: olist){
            if(o.account.name!=null && o.name!=null){
                o.account.name=o.name;
                update o.account;
            }
        }
        
    }
	
    global void finish(database.batchablecontext bc){
	
    }
}