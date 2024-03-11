trigger Seven on Account (before insert) {
    
    for(Account a:trigger.new){
         a.Name='Mr.'+a.Name;
    }

}