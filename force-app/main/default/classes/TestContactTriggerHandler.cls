@isTest
public class TestContactTriggerHandler {

    @isTest
    static void Eight() {
        List<Account> testAccounts = new List<Account>();
        List<Contact> testContacts = new List<Contact>();
        for(Integer i = 0; i < 5; i++) {
            Account testAccount = new Account(Name = 'Test Account ' + i);
            testAccounts.add(testAccount);
            
            Contact testContact = new Contact(LastName = 'Test Contact ' + i, AccountId = testAccount.Id);
            testContacts.add(testContact);
        }
        insert testAccounts;
        insert testContacts;

         
        Test.startTest();
        delete testContacts;
        Test.stopTest();

         
        List<Account> deletedAccounts = [SELECT Id FROM Account WHERE Id IN :testAccounts];
        System.assert(deletedAccounts.size()==0, 'Accounts related to Contacts should have been deleted');
    }
    @isTest
    static void Eleven(){
        
        List <Contact> lcontact = new List<Contact>();
        
        for(Integer i=0;i<5;i++){
            Contact con = new Contact();
            con.lastname='test contact'+i;
            lcontact.add(con);
        }
        
        Test.startTest();
        insert lcontact;
        Test.stopTest();
        
        List <Event> event=[select ID from Event where whoId IN: lcontact];
        System.assert(event.size()==5,'Size should be 5');
    }
    

    @isTest
    static void testRollupSummaryTrigger() {
        Account testAccount = new Account(Name = 'Test Account');
        insert testAccount;

        List<Contact> testContacts = new List<Contact>();
        for(Integer i = 0; i < 5; i++) {
            Contact testContact = new Contact(
                LastName = 'Test Contact ' + i,
                AccountId = testAccount.Id,
                Amount__c = 100
            );
            testContacts.add(testContact);
        }
        Test.startTest();
        insert testContacts;
		Test.stopTest();
        
        testAccount = [SELECT Total_Amount__c FROM Account WHERE Id = :testAccount.Id];
        System.assert(testAccount.Total_Amount__c==500, 'Total_Amount__c should be the sum of Amount__c from related Contacts');

        testContacts[0].Amount__c = 50;
        update testContacts[0];

        testAccount = [SELECT Total_Amount__c FROM Account WHERE Id = :testAccount.Id];
        System.assert(testAccount.Total_Amount__c==450, 'Total_Amount__c should be updated after Contact update');

          }
     @isTest
    static void testSheepProblemTrigger() {
        Account testAccount1 = new Account(Name = 'Test Account 1');
        Account testAccount2 = new Account(Name = 'Test Account 2');
        insert new List<Account>{testAccount1, testAccount2};

        Contact testContact1 = new Contact(LastName = 'Test Contact 1', AccountId = testAccount1.Id);
        Contact testContact2 = new Contact(LastName = 'Test Contact 2', AccountId = testAccount1.Id);
        insert new List<Contact>{testContact1, testContact2};

        testContact1.AccountId = testAccount2.Id;
        update testContact1;

        Contact updatedContact1 = [SELECT AccountId FROM Contact WHERE Id = :testContact1.Id];
        System.assert(updatedContact1.AccountId==testAccount2.Id, 'Contact should be associated with the second Account after update');
    }
    

    @isTest
    static void testTriggerLogic() {
        Account testAccount = new Account(Name = 'Test Account');
        insert testAccount;

        Contact testContact1 = new Contact(LastName = 'Test1', AccountId = testAccount.Id, Limited_Amount__c = 45);
        Contact testContact2 = new Contact(LastName = 'Test2', AccountId = testAccount.Id, Limited_Amount__c = 25);
        Contact testContact3 = new Contact(LastName = 'Test3', AccountId = testAccount.Id, Limited_Amount__c = 60);
        List<Contact> testContacts = new List<Contact>{testContact1, testContact2, testContact3};
        insert testContacts;

        List<Contact> createdContacts = [SELECT LastName, AccountId, Limited_Amount__c FROM Contact WHERE AccountId = :testAccount.Id];
        System.assertEquals(5, createdContacts.size());
         
    }
}