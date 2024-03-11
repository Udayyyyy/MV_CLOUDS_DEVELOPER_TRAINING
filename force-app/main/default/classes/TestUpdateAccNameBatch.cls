@isTest
public class TestUpdateAccNameBatch {

    @isTest
    static void testUpdateAccName() { 
        List<Account> testAccounts = new List<Account>();
        List<Opportunity> testOpportunities = new List<Opportunity>();
        for (Integer i = 0; i < 5; i++) {
            Account acc = new Account(Name = 'Test Account ' + i);
            testAccounts.add(acc);

            Opportunity opp = new Opportunity(
                Name = 'Test Opportunity ' + i,
                StageName = 'Prospecting',
                CloseDate = Date.today().addDays(10),
                AccountId = acc.Id
            );
            testOpportunities.add(opp);
        }
        insert testAccounts;
        insert testOpportunities;
 
        Test.startTest();
        UpdateAccNameBatch batchJob = new UpdateAccNameBatch();
        Database.executeBatch(batchJob);
        Test.stopTest();
 
    }
}