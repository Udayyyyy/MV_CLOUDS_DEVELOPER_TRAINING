public with sharing class RelatedRecordsController {
    @AuraEnabled(cacheable=true)
    public static List<Contact> getRelatedContacts(Id accountId) {
        return [SELECT Id, Name FROM Contact WHERE AccountId = :accountId];
    }

    @AuraEnabled(cacheable=true)
    public static List<Opportunity> getRelatedOpportunities(Id accountId) {
        return [SELECT Id, Name FROM Opportunity WHERE AccountId = :accountId];
    }
}
