trigger Rollup_Summary on Contact (after insert, after delete, after update) {
    Set<Id> accid =  new Set<Id>();
    
    if(trigger.isAfter){
        
       for(Contact con  : Trigger.new){
       accid.add(con.AccountId); 
    }
        List<Account> alist = [Select Id, Total_Amount__c,(Select Id ,LastName , AccountId ,Amount__c FROM Contacts) From Account Where Id IN: accid];
        
        List<Account> alists = New  List<Account>();
        
        for(Account a: alist){
            double  sumAmount = 0;
            for(Contact c : a.Contacts){
                sumAmount+=c.Amount__c;
            }
         a.Total_Amount__c=sumAmount;
         alists.add(a);
        }
        
        if(alists.Size() > 0){
            Update alists;   
    }
         
        
}

}