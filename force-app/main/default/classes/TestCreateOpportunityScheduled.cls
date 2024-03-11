@isTest
public class TestCreateOpportunityScheduled {

    @isTest
    static void testScheduledJob() { 
        String cronExp = '0 30 11 * * ?';
        Test.startTest(); 
        String jobId = System.schedule('Test Scheduled Job', cronExp, new CreateOpportunityScheduled());
        Test.stopTest();
         
        System.assertNotEquals(null, jobId, 'Job ID should not be null');
 
        Integer expectedOpportunityCount = 10;
        Integer actualOpportunityCount = [SELECT COUNT() FROM Opportunity];
        System.assertEquals(expectedOpportunityCount, actualOpportunityCount, 'Incorrect number of Opportunity records created');

  
        System.abortJob(jobId);
    }
}