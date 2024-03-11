trigger forlead on Lead (before insert) {
    
    if(Trigger.isBefore){
        if(Trigger.isInsert){
            LeadTriggerHandler.Two(Trigger.new);
        }
    }
  }