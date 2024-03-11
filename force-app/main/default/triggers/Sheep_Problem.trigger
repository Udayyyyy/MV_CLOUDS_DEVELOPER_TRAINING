trigger Sheep_Problem on Contact (after update) {
    Map<ID, ID> oldToNew = new Map<ID, ID>();

    if(Trigger.isAfter){
        for(Contact oldCon : Trigger.old){
            Contact newCon = Trigger.newMap.get(oldCon.Id);
            if(oldCon.AccountId != newCon.AccountId){
                oldToNew.put(oldCon.AccountId, newCon.AccountId);
            }
        }
        
        if(!oldToNew.isEmpty()){
            List<Contact> contactsToUpdate = [SELECT Id, AccountId FROM Contact WHERE AccountId IN :oldToNew.keySet()];
            for(Contact c : contactsToUpdate){
                c.AccountId = oldToNew.get(c.AccountId);
            }
            update contactsToUpdate;
        }
    }
}