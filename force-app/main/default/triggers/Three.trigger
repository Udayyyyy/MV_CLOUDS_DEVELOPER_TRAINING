trigger Three on Opportunity (before update) {
    
    for(Opportunity O:trigger.new){
        O.StageName='prospecting';
        O.CloseDate=Date.today().addDays(15);
    }

}