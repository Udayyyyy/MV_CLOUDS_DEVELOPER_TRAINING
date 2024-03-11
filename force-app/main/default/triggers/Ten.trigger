trigger Ten on Account (after insert) {
    Contact c ;
    for(Account a:trigger.new){
          c = new Contact(LastName = a.name,AccountId=a.id);
        insert c;   
    }
    

}