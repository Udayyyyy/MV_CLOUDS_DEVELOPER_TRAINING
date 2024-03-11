@isTest
public class TestThreeTrigger {
 
    @isTest
    static void testOpportunityUpdate() {
         
        List<Opportunity> testOpportunities = new List<Opportunity>();
        for(Integer i = 0; i < 5; i++) {
            Opportunity testOpportunity = new Opportunity(
                Name = 'TestOpportunity' + i,
                StageName = 'Old Stage',
                CloseDate = Date.today().addDays(5)
            );
            testOpportunities.add(testOpportunity);
        }
        
         insert testOpportunities;
        
         for(Opportunity o : testOpportunities) {
            o.StageName = 'New Stage';
            o.CloseDate = Date.today().addDays(10);
        }
        
        Test.startTest();
        update testOpportunities;
        Test.stopTest();
        
         for(Opportunity opp : [SELECT Id, StageName, CloseDate FROM Opportunity WHERE Id IN :testOpportunities]) {
            System.assert(opp.StageName == 'prospecting', 'Opportunity StageName should be prospecting, but was: ' + opp.StageName);
			System.assert(opp.CloseDate == Date.today().addDays(15), 'Opportunity CloseDate should be 15 days from today, but was: ' + opp.CloseDate);
 }
    }
}