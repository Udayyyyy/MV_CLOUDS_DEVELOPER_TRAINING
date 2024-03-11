trigger foraccount on Account (after update, after insert,before insert, before update, before delete) {
    AccountTriggerHandler.One();
    if (Trigger.isAfter) {
        AccountTriggerHandler.sharehotrecords();
        if (Trigger.isUpdate) {
            AccountTriggerHandler.Five(Trigger.new, Trigger.oldMap);
        }
        if (Trigger.isInsert) {
            AccountTriggerHandler.Nine(Trigger.new);
            AccountTriggerHandler.Ten(Trigger.new);
        }
    }        
    if (Trigger.isBefore) { 
        if (Trigger.isInsert) {
            AccountTriggerHandler.Seven(Trigger.new);
            AccountTriggerHandler.Twelve(Trigger.new);
        }
    }    
}