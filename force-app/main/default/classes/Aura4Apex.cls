public class Aura4Apex {
    @AuraEnabled
    public static string save(Account accountData, Contact contactData, Event eventData){
        try{
            System.debug('accountData::::'+accountData);
            System.debug('contactData::::'+contactData);
            System.debug('eventData::::'+eventData);
            
            insert accountData;
            contactData.AccountId = accountData.Id;
            insert contactData;
            eventData.WhatId = accountData.Id;
            eventData.OwnerId = '0055j00000COrODAA1';
            insert eventData;
        }
        catch(Exception ex){
            return ex.getMessage();
        }
        return 'Record successfully inserted';  
    }
}
