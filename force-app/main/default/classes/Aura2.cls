public class Aura2 {
    @AuraEnabled(cacheable=true)
    public static List<Contact> getAccountContacts() {
        return [SELECT Id, Name, Email FROM Contact WHERE AccountId = :'0015j00001ZBmH9AAL'];
    }

@AuraEnabled
public static List<Contact> getByName(String searchKey) {
String name = '%' + searchKey + '%';

        return [SELECT Id, Name, Email FROM Contact WHERE Name LIKE :name and AccountId = :'0015j00001ZBmH9AAL'];

}
}
