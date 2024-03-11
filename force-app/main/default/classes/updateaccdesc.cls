global class updateaccdesc implements Database.Batchable<sObject> {
    
    global Database.QueryLocator start(Database.BatchableContext BC) {
        return Database.getQueryLocator('SELECT Id, Description FROM Account');
    }

    global void execute(Database.BatchableContext BC, List<Account> scope) {
        for(Account acc : scope) {
            acc.Description = Datetime.now().format('dd-MM-yyyy HH:mm:ss');
        }
        update scope;
    }

    global void finish(Database.BatchableContext BC) {
        
    }
}