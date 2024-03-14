public with sharing class DropdownController {
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccountOptions() { 
        return [SELECT Id, Name FROM Account];
    }
}
