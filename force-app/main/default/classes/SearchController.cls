public with sharing class SearchController {

    @AuraEnabled(cacheable=true)
    public static List<String> searchAll(String searchTerm, List<String> selectedObjects) {
        List<String> searchResults = new List<String>();
        for(String selectedObject : selectedObjects) {
            if(selectedObject == 'Account') {
                searchResults.addAll(searchAccounts(searchTerm));
            } else if(selectedObject == 'Contact') {
                searchResults.addAll(searchContacts(searchTerm));
            } else if(selectedObject == 'Opportunity') {
                searchResults.addAll(searchOpportunities(searchTerm));
            }
        }
        
        return searchResults;
    }

    private static List<String> searchAccounts(String searchTerm) {
        List<String> accountResults = new List<String>();
        List<List<SObject>> results = [FIND :searchTerm IN ALL FIELDS RETURNING Account(Name)];
        for (List<SObject> records : results) {
            for (SObject record : records) {
                Account acc = (Account) record;
                accountResults.add(acc.Name + ' -From Account');
            }
        }
        return accountResults;
    }

    private static List<String> searchContacts(String searchTerm) {
        List<String> contactResults = new List<String>();
        List<List<SObject>> results = [FIND :searchTerm IN ALL FIELDS RETURNING Contact(Name)];
        for (List<SObject> records : results) {
            for (SObject record : records) {
                Contact con = (Contact) record;
                contactResults.add(con.Name + ' -From Contact');
            }
        }
        return contactResults;
    }

    private static List<String> searchOpportunities(String searchTerm) {
        List<String> opportunityResults = new List<String>();
        List<List<SObject>> results = [FIND :searchTerm IN ALL FIELDS RETURNING Opportunity(Name)];
        for (List<SObject> records : results) {
            for (SObject record : records) {
                Opportunity opp = (Opportunity) record;
                opportunityResults.add(opp.Name + ' -From Opportunity');
            }
        }
        return opportunityResults;
    }
}
