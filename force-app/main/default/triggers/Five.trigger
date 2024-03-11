trigger Five on Account (after update) {
    List<Messaging.SingleEmailMessage> emaillist = new List<Messaging.SingleEmailMessage>();
    
    for (Account acc : Trigger.new) {
        if (acc.Name != Trigger.oldMap.get(acc.Id).Name) {
            List<Contact> relatedContacts = [SELECT Id, Email FROM Contact WHERE AccountId = :acc.Id];
            
            for (Contact con : relatedContacts) {
                Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
                email.setToAddresses(new List<String>{con.Email});
                email.setSubject('Account Name Update Notification');
                email.setPlainTextBody('The name of the Account ' + acc.Name + ' has been modified.');
                emaillist.add(email);
            }
        }
    }
    
    if (!emaillist.isEmpty()) {
        Messaging.sendEmail(emaillist);
    }
}