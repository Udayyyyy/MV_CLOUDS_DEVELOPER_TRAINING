trigger Six on Opportunity (after update) {
    
	List<Task> tasks = new List<Task>();
    for(Opportunity opp : Trigger.New){
        if(opp.Name != Trigger.oldmap.get(opp.Id).Name){
         	tasks.add(new Task(OwnerId = opp.OwnerId,Subject = 'Follow Up Test Task'));   
        } 
    }
    if(tasks.size() > 0){
        insert tasks;
    }  
}