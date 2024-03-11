trigger Twelve on Account (before insert) {
    
    List<String> accname=new List<String>();
    
    for(Account a:trigger.new){
            accname.add(a.name);
    }
     List<Account> sameacc=[select id from Account where name in:accname];
    delete sameacc;
}