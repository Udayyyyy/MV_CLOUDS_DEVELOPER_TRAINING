trigger One on Account (before update, before delete,after insert) {
    System.debug('Trigger Context Variables:');
    System.debug('Trigger.isExecuting: ' + Trigger.isExecuting);
    System.debug('Trigger.isBefore: ' + Trigger.isBefore);
    System.debug('Trigger.isAfter: ' + Trigger.isAfter);
    System.debug('Trigger.new: ' + Trigger.new);
    System.debug('Trigger.old: ' + Trigger.old);
    System.debug('Trigger.newMap: ' + Trigger.newMap);
    System.debug('Trigger.oldMap: ' + Trigger.oldMap);
    System.debug('Trigger.size: ' + Trigger.size);
    System.debug('Trigger.operationType: ' + Trigger.operationType);
}