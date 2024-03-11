@isTest
public class TestAccountTriggerHandler {
     
    @isTest
    static void testShareHotRecords() {
        List<Account> hotAccounts = new List<Account>();
        for (Integer i = 0; i < 5; i++) {
            hotAccounts.add(new Account(Name = 'Hot Account ' + i, Rating = 'Hot'));
        }
        insert hotAccounts;
 
        Test.startTest();
        AccountTriggerHandler.sharehotrecords();
        Test.stopTest(); 
        
    }


    @isTest
    static void Five() {
        Account testAccount = new Account(Name = 'Test Account');
        insert testAccount;
        
        Contact testContact1 = new Contact(LastName = 'Test Contact 1', AccountId = testAccount.Id, Email = 'test1@gmail.com'); 
        insert testContact1;
        
        testAccount.Name = 'Updated Account';
        
        Test.startTest();
        update testAccount;
        Test.stopTest();
         
 
    }
        @isTest
    static void Nine() {
         List <Account> alist = new List <Account>();
       
        for(integer i=0;i<5;i++){
         Account testAccount = new Account(Name = 'Test Account');
       	 alist.add(testAccount);
        }
        
        Test.startTest();
        insert alist;
        Test.stopTest();
        }
 
    @isTest
    static void seven() {
         
        List<Account> testAccounts = new List<Account>();
        for (Integer i = 0; i < 5; i++) {
            testAccounts.add(new Account(Name = 'Test Account ' + i));
        }
        
         
        Test.startTest();
        insert testAccounts;
        Test.stopTest();

        List<Account> updatedAccounts = [SELECT Name FROM Account WHERE Id IN :testAccounts];
        for (Account acc : updatedAccounts) {
            System.assertEquals('Mr.', acc.Name.subString(0, 3));
        }
    }
     @isTest
    static void ten() {
        List<Account> testAccounts = new List<Account>();
        for (Integer i = 0; i < 5; i++) {
            testAccounts.add(new Account(Name = 'Test Account ' + i));
        }
        
        Test.startTest();
        insert testAccounts;
        Test.stopTest();
        
        List<Contact> createdContacts = [SELECT LastName, AccountId FROM Contact WHERE AccountId IN :testAccounts];
        System.assert(createdContacts.size()==5, 'Five contacts should be created');
    
        }  
    @isTest
    static void twelve() {
        
        List<Account> testAccounts = new List<Account>();
        for (Integer i = 0; i < 5; i++) {
            testAccounts.add(new Account(Name = 'Test Account ' + i));
        }
        insert testAccounts;
 
        List<Account> duplicateAccounts = new List<Account>();
         
        duplicateAccounts.add(new Account(Name = 'Unique Account 1'));
        duplicateAccounts.add(new Account(Name = 'Unique Account 2'));
 
        for (Integer i = 0; i < 3; i++) {
            duplicateAccounts.add(new Account(Name = 'Test Account ' + i));
        }
 
        Test.startTest();
        insert duplicateAccounts;
        Test.stopTest();
  
         
    }
}