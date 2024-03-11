@isTest
public class TestFourTrigger {

    @isTest
    static void testOpportunityTypeUpdate() {
        List<Opportunity> testOpportunities = new List<Opportunity>();
        for(Integer i = 0; i < 5; i++) {
            Opportunity testOpportunity = new Opportunity(
                Name = 'TestOpportunity' + i,
                StageName = 'Prospecting',
                CloseDate = Date.today().addDays(10)
            );
            testOpportunities.add(testOpportunity);
        }
        
        Test.startTest();
        insert testOpportunities;
        Test.stopTest();
        
        for(Opportunity opp : [SELECT Id, Type FROM Opportunity WHERE Id IN :testOpportunities]) {
            System.assert(opp.Type == 'New Customer', 'Opportunity Type should be updated to New Customer');
        }
    }
}