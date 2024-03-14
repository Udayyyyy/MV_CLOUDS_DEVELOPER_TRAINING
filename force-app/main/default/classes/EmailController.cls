public with sharing class EmailController {
    @AuraEnabled
    public static void sendEmail(String subject, String body, List<Id> recordIds, String objectType) {
        List<Messaging.SingleEmailMessage> emailMessages = new List<Messaging.SingleEmailMessage>();
 
        Map<Id, String> recordEmails = new Map<Id, String>();

        if (objectType == 'Lead') {
            for (Lead lead : [SELECT Id, Email FROM Lead WHERE Id IN :recordIds AND Email != null]) {
                recordEmails.put(lead.Id, lead.Email);
            }
        } else if (objectType == 'Account') {
            for (Account account : [SELECT Id, Email__c FROM Account WHERE Id IN :recordIds AND Email__c != null]) {
                recordEmails.put(account.Id, account.Email__c);
            }
            
            // Account account = [SELECT Id, Email__c FROM Account WHERE Id='0015j00001YQJfdAAH'];
            // System.debug(account);
            // recordEmails.put(account.Id, account.Email__c);
        } else if (objectType == 'Contact') {
            for (Contact contact : [SELECT Id, Email FROM Contact WHERE Id IN :recordIds AND Email != null]) {
                recordEmails.put(contact.Id, contact.Email);
            }
        }
        System.debug(recordEmails);
        System.debug(recordIds);
        for (Id recordId : recordIds) {
            String recordEmail = recordEmails.get(recordId);
            if (recordEmail != null) {
                Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
                email.setSubject(subject);
                email.setHtmlBody(body);
                email.setSaveAsActivity(false); // Do not save email as an activity
                email.setToAddresses(new List<String>{recordEmail});
                System.debug('email: ' + email.toString());
                emailMessages.add(email);
            }
        }
                System.debug('hi');
                System.debug(subject);
                System.debug(body); 
  
        try {
            Messaging.sendEmail(emailMessages);
            System.debug('success sent');
        } catch (Exception e) {
            system.debug('Error sending email: ' + e.getMessage());
            throw new AuraHandledException('Error sending email: ' + e.getMessage());
        }
    }
     @AuraEnabled(cacheable=true)
    public static List<SObject> getRelatedRecords(String objectType) {
        String query = 'SELECT Id, Name FROM ' + objectType;
        return Database.query(query);
    }
}
