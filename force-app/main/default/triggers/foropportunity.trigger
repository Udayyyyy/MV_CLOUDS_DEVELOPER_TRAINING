trigger foropportunity on Opportunity (before insert, before update, after update) {
    
    if(Trigger.isBefore){
        if(Trigger.isInsert){
            OpportunityTriggerHandler.Four(Trigger.new);
        }
        if(Trigger.isUpdate){
            OpportunityTriggerHandler.Three(Trigger.new);
        }
    }
    
    if(Trigger.isAfter){
        if(Trigger.isUpdate){
            OpportunityTriggerHandler.Six(Trigger.new,Trigger.oldmap);
        }
    }

}