trigger The_Great_Problem on Contact (before insert, before delete, before update) {

         
    if(trigger.isbefore){        
       for(Contact con  : Trigger.new){
           Integer i=2;
           double Amount=con.Limited_Amount__c;
           if(Amount>30){
               while(Amount>30){
                   Contact c = new Contact();
                   c.LastName = con.LastName+i;
                   c.AccountId =con.AccountId;
                   c.Limited_Amount__c=30;
                   insert (c);
                   i+=1;
                   Amount-=30;
                   }
                con.Limited_Amount__c=Amount;
            
           }
    
}
}
}