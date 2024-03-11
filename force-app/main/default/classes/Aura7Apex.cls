public class Aura7Apex {
    
    public class AccountWrapper {
        @AuraEnabled
        public Account account;
        @AuraEnabled
        public List<Opportunity> opportunities;
        @AuraEnabled
        public List<Contact> contacts;
        
        public AccountWrapper(Account acc, List<Opportunity> opps, List<Contact> cons) {
            account = acc;
            opportunities = opps;
            contacts = cons;
        }
    }
    
    @AuraEnabled
    public static List<AccountWrapper> getAccountsWithRelatedInfo() {
        List<AccountWrapper> accountWrappers = new List<AccountWrapper>();
         
        List<Account> accounts = [SELECT Name, (SELECT Name FROM Opportunities), (SELECT Name FROM Contacts) FROM Account];
         
        for (Account acc : accounts) {
            List<Opportunity> opps = new List<Opportunity>();
            List<Contact> cons = new List<Contact>();
            
            for (Opportunity opp : acc.Opportunities) {
                opps.add(opp);
            }
            
            for (Contact con : acc.Contacts) {
                cons.add(con);
            }
            
            accountWrappers.add(new AccountWrapper(acc, opps, cons));
        }
        
        return accountWrappers;
    }
}
