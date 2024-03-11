public with sharing class Aura3 {
   
    @AuraEnabled
    public static List<Contact> searchaccountcontact(String searchkey) { 

        List<Account> acclist = [SELECT Id, Name,(SELECT Id, Name, Email, Phone  FROM Contacts) FROM Account WHERE Name LIKE :searchkey];
        List<Contact> conlist = New List <Contact>();
        for (Account acc : acclist) {
        System.debug('Account Name: ' + acc.Name); 
        List<Contact> contacts = acc.Contacts;
        for (Contact con : contacts) {
            System.debug('Contact Name: ' + con.Name);
            conlist.add(con);
        }
}
    return conlist;
    }
   @AuraEnabled
    public static void updateContactAccountId(String contactId, String accountId) { 
        Contact con = [SELECT Id,AccountId FROM Contact WHERE Id = :contactId LIMIT 1];
        if (con != null) {
            con.AccountId = accountId;
            update con;
        }
    }
}
