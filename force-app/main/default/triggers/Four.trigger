trigger Four on Opportunity (before insert) {
    
    for(Opportunity O:trigger.new){
        O.Type=' New Customer';
         
    }

}