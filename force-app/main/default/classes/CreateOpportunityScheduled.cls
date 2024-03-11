global class CreateOpportunityScheduled implements Schedulable {
    global void execute(SchedulableContext sc) {
        List<Opportunity> oppsToCreate = new List<Opportunity>();
        
        for(Integer i = 0; i < 10; i++) {
            Opportunity newOpp = new Opportunity();
            newOpp.Name='Opportunity ' + Datetime.now().formatGMT('yyyy-MM-dd HH:mm:ss');
            newOpp.StageName='Prospecting';
            newOpp.Amount=1000;
            newOpp.CloseDate=Date.today().addDays(7);
            oppsToCreate.add(newOpp);
        }
        
        insert oppsToCreate;
    }
}