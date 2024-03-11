@isTest
public class TestUpdateAccDescBatch {
    @isTest
    static void testBatchExecution() {
         
        List<Account> testAccounts = new List<Account>();
        for(Integer i = 0; i < 5; i++) {
            Account acc = new Account(Name = 'Test Account ' + i);
            testAccounts.add(acc);
        }
        insert testAccounts;
        
       
        Test.startTest();
        updateaccdesc batchJob = new updateaccdesc();
        Database.executeBatch(batchJob);
        Test.stopTest();
         
        List<Account> updatedAccounts = [SELECT Id, Description FROM Account WHERE Id IN :testAccounts];
        for(Account acc : updatedAccounts) {
            System.assertNotEquals(null, acc.Description); 
            Datetime currentDatetime = Datetime.now();
            String expectedDescription = currentDatetime.format('dd-MM-yyyy HH:mm:ss');
            System.assertEquals(expectedDescription, acc.Description);
        }
    }
}