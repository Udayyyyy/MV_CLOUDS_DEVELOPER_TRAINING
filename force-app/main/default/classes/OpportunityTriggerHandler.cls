public class OpportunityTriggerHandler {
    
    public static void Four(List<Opportunity> opp){
       for(Opportunity O:opp){
        O.Type=' New Customer';
       }
        
    }
    
        public static void Six(List<Opportunity> newopp,Map<Id,Opportunity> oldopp){
        List<Task> tasks = new List<Task>();
    for(Opportunity opp : newopp){
        if(opp.Name != oldopp.get(opp.Id).Name){
         	tasks.add(new Task(OwnerId = opp.OwnerId,Subject = 'Follow Up Test Task'));   
        } 
    }
    if(tasks.size() > 0){
        insert tasks;
    }  
    }
     public static void Three(List<Opportunity> opp){  
         for(Opportunity O:opp){
        O.StageName='prospecting';
        O.CloseDate=Date.today().addDays(15);
    }
        
    }

}