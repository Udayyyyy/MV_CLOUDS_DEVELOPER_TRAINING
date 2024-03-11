@isTest
public class TestTwoTrigger {

     
    @isTest
    static void testLeadRatingSetToHot() {
         List<Lead> testLeads = new List<Lead>();
        for(Integer i = 0; i < 5; i++) {
            Lead testLead = new Lead(
                FirstName = 'TestFirstName' + i,
                LastName = 'TestLastName' + i,
                Company = 'TestCompany' + i,
                Email = 'testemail' + i + '@example.com'
                
            );
            testLeads.add(testLead);
        }
        
         
        Test.startTest();
        insert testLeads;
        Test.stopTest();
        
         
        for(Lead l : [SELECT Id, Rating FROM Lead WHERE Id IN :testLeads]) {
            System.assert( l.Rating=='hot', 'Lead rating should be set to hot');
                          
        }
    }
}