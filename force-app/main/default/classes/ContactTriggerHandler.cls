public class ContactTriggerHandler {
    
    public static void Eight(List <Contact> oldcon){
    List<Id> accId = new List<Id>();
    for(Contact c : oldcon){
        accId.add(c.AccountId);
    }
    List<Account> accdelete = [select Id from Account where Id IN :accId];
    if(accdelete.size() > 0){
        delete accdelete;
    }
  }
    public static void Eleven(List <Contact> con){
        List<Event> elist = new List<Event>();
    
    for (Contact c : con) {
         Event e = new Event(
            Subject = 'New Contact Meeting',
            StartDateTime = DateTime.now(),  
            EndDateTime = DateTime.now().addHours(3),  
            WhoId = c.Id 
        );
        
        elist.add(e);
    }
    

    if (!elist.isEmpty()) {
        insert elist;
    }
    }
    
    public static void Rollup_Summary(List <Contact> newcon){
         
       Set<Id> accid =  new Set<Id>();          
       for(Contact con  : newcon){
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
    
    public static void Sheep_Problem(List<Contact> oldContacts, Map<Id, Contact> newMap){
         Map<ID, ID> oldToNew = new Map<ID, ID>();
            for(Contact oldCon : oldContacts){
            Contact newCon =newMap.get(oldCon.Id);
            if(oldCon.AccountId != newCon.AccountId){
                oldToNew.put(oldCon.AccountId, newCon.AccountId);
            }
        }
        
        if(!oldToNew.isEmpty()){
            List<Contact> contactsToUpdate = [SELECT Id, AccountId FROM Contact WHERE AccountId IN :oldToNew.keySet()];
            for(Contact c : contactsToUpdate){
                c.AccountId = oldToNew.get(c.AccountId);
            }
            update contactsToUpdate;
        }
    
    }
    
    public static void The_Great_Problem(List<Contact> newcon){
          for(Contact con  : newcon){
           Integer i=2;
           double Amount=con.Limited_Amount__c;
           if(Amount>30){
               while(Amount>30){
                   Contact c = new Contact();
                   c.LastName = con.LastName+i;
                   c.AccountId =con.AccountId;
                   c.Limited_Amount__c=30;
                   insert (c);
                   i+=1;
                   Amount-=30;
                   }
                con.Limited_Amount__c=Amount;
            
           }
    
}
    }

}