@isTest
public class TestUpdaterating {
    @isTest
    static void testupdaterating(){
        List <Lead> Leadlist = new List <Lead>();
        for(Integer i=0;i<5;i++){
            
            Lead l=new Lead();
            l.LastName='lead '+i;
            l.Company='xyz '+i;
            l.AnnualRevenue=55000;
            Leadlist.add(l);
            
        }
        insert Leadlist;
        
        Test.startTest();
        String jobid=system.schedule('update rating to warm','0 0 9 * * ?',new UpdateRatingScheduled());
        Test.stopTest();
        
        List<Lead> updatedLeads = [SELECT Id, Rating FROM Lead WHERE AnnualRevenue > 10000 AND AnnualRevenue <= 100000];
        for (Lead lead : updatedLeads) {
            System.assert(lead.Rating=='warm', 'Lead rating should be updated to "warm"');
        }
 
        System.abortJob(jobId);
    }
}