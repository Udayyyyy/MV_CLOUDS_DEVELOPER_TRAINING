public with sharing class Aura3 {
   
    @AuraEnabled
    public static List<Account> searchAccounts(String searchkey) {
        String name = '%' + searchKey + '%';
        return [SELECT Id, Name FROM Account WHERE Name LIKE :name];
    }

    @AuraEnabled
    public static List<Contact> getContactsByAccountId(String accountId) {
        return [SELECT Id, Name, Email, Phone FROM Contact WHERE AccountId = :accountId];
    }

    @AuraEnabled
    public static void updateContactAccountId(String contactId, String accountId) { 
        Contact con = [SELECT Id, AccountId FROM Contact WHERE Id = :contactId LIMIT 1];
        if (con != null) {
            con.AccountId = accountId;
            update con;
        }
    }
}
