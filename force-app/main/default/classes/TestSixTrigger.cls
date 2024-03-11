@isTest
public class TestSixTrigger {

    @isTest
    static void testTaskCreationOnOpportunityNameChange() {
        List<Opportunity> testOpportunities = new List<Opportunity>();
        for(Integer i = 0; i < 5; i++) {
            Opportunity testOpportunity = new Opportunity(
                Name = 'TestOpportunity' + i,
                StageName = 'Prospecting',
                CloseDate = Date.today().addDays(10)
            );
            testOpportunities.add(testOpportunity);
        }
        
        insert testOpportunities;
        
        for(Opportunity opp : testOpportunities) {
            Integer i=1;
            opp.Name = 'ModifiedTestOpportunity'+i;
            i++;
        }
        
        Test.startTest();
        
        update testOpportunities;
        
        Test.stopTest();
        
        Set<Id> opportunityIds = new Set<Id>();
        for(Opportunity opp : testOpportunities) {
            opportunityIds.add(opp.Id);
        }
        
        List<Task> createdTasks = [SELECT Id, OwnerId, Subject FROM Task WHERE WhatId IN :opportunityIds];
        
          
        for(Task task : createdTasks) {
            System.assert(task.Subject == 'Follow Up Test Task', 'Task subject should be "Follow Up Test Task"');
        }
    }
}