public class AccountTriggerHandler {
    
    public static void sharehotrecords() {
        List<Account> hotacc = [SELECT Id FROM Account WHERE Rating = 'Hot'];
        List<AccountShare> accountSharesToInsert = new List<AccountShare>();
        
        for (Account hotAccount : hotacc) {
            AccountShare accShare = new AccountShare();
            accShare.AccountId = hotAccount.Id;
            accShare.UserOrGroupId = '0055j00000CP1VZAA1';  
            accShare.AccountAccessLevel = 'Read';
            accShare.OpportunityAccessLevel = 'Read';
            accountSharesToInsert.add(accShare);
        }
        
        if (!accountSharesToInsert.isEmpty()) {
            insert accountSharesToInsert;
            system.debug('Thirteen(hot) done');
        } 
    }
    
    public static void Five(List<Account> newAccounts, Map<Id, Account> oldAccountMap){
        List<Messaging.SingleEmailMessage> emailList = new List<Messaging.SingleEmailMessage>();
        
        for (Account newAcc : newAccounts) {
            Account oldAcc = oldAccountMap.get(newAcc.Id);
            if (newAcc.Name != oldAcc.Name) {
                List<Contact> relatedContacts = [SELECT Id, Email FROM Contact WHERE AccountId = :newAcc.Id];
                
                for (Contact con : relatedContacts) {
                    Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
                    email.setToAddresses(new List<String>{con.Email});
                    email.setSubject('Account Name Update Notification');
                    email.setPlainTextBody('The name of the Account ' + newAcc.Name + ' has been modified.');
                    emailList.add(email);
                }
            }
        }
        
        if (!emailList.isEmpty()) {
            Messaging.sendEmail(emailList);
            
        }
    }
    
    public static void Nine(List<Account> newAcc){
        
    for(Account a:newAcc){
    Approval.ProcessSubmitRequest req1 = new Approval.ProcessSubmitRequest();
    req1.setComments('Submitting request for approval.');
    req1.setObjectId( a.id );
    req1.setSubmitterId( UserInfo.getUserId() );
    req1.setProcessDefinitionNameOrId('accapp');
    Approval.process(req1);
		}
	}
    
    public static void Seven(List<Account> acc){
         for(Account a:acc){
         a.Name='Mr.'+a.Name;
    }
    }
    
    public static void Ten(List <Account> acc){
    Contact c ;
    for(Account a:acc){
          c = new Contact(LastName = a.name,AccountId=a.id);
        insert c; 
    }
    
    }
    
  public static void Twelve(List <Account> acc){
 	List<String> accname=new List<String>();
    
    for(Account a:acc){
            accname.add(a.name);
    }
     List<Account> sameacc=[select id from Account where name in:accname];
    delete sameacc;
    
    }
  public static void One(){
    System.debug('Trigger Context Variables:');
    System.debug('Trigger.isExecuting: ' + Trigger.isExecuting);
    System.debug('Trigger.isBefore: ' + Trigger.isBefore);
    System.debug('Trigger.isAfter: ' + Trigger.isAfter);
    System.debug('Trigger.new: ' + Trigger.new);
    System.debug('Trigger.old: ' + Trigger.old);
    System.debug('Trigger.newMap: ' + Trigger.newMap);
    System.debug('Trigger.oldMap: ' + Trigger.oldMap);
    System.debug('Trigger.size: ' + Trigger.size);
    System.debug('Trigger.operationType: ' + Trigger.operationType);

    }
      
}