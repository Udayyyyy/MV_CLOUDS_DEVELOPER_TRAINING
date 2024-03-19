public class Aura2 {
    @AuraEnabled(cacheable=true)
    public static List<Contact> getAccountContacts(String accountId) {
        System.debug(accountId);
        return [SELECT Id, Name, Email FROM Contact WHERE AccountId = : accountId];
    }

@AuraEnabled
public static List<Contact> getByName(String searchKey,String accountId) {
String name = '%' + searchKey + '%';

        return [SELECT Id, Name, Email FROM Contact WHERE Name LIKE :name and AccountId = : accountId];

}
}
