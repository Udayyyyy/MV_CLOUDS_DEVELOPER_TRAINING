trigger Two on Lead (before insert) {
    
    for(Lead l : trigger.new ){
        l.rating='hot';
    }

}