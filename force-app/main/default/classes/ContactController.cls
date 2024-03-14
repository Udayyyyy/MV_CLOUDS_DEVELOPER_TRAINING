public with sharing class ContactController {
    @AuraEnabled(cacheable=false)
    public static Contact createContact(String LastName,String MobilePhone) {
        Contact newContact = new Contact();
        newContact.LastName = LastName;
        newContact.MobilePhone = MobilePhone;
        insert newContact;
        return newContact;
    }
}
