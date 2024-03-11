trigger forcontact on Contact (after update, after insert,before insert, after delete) {
     if (Trigger.isAfter) { 
         if (Trigger.isDelete) {
        ContactTriggerHandler.Eight(Trigger.old);
        }
         if (Trigger.isInsert) {
        ContactTriggerHandler.Eleven(Trigger.new);
        }
        if (Trigger.isInsert || Trigger.isUpdate ||Trigger.isDelete) {
        //ContactTriggerHandler.Rollup_Summary(Trigger.new);
        }
         if (Trigger.isUpdate) { 
             ContactTriggerHandler.Sheep_Problem(Trigger.old, Trigger.newMap);
   }
     }
    if(Trigger.isBefore){
         if (Trigger.isInsert || Trigger.isUpdate ||Trigger.isDelete) {
        ContactTriggerHandler.The_Great_Problem(Trigger.new);
        }
    }
         
 
}