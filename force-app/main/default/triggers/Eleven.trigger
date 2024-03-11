trigger Eleven on Contact (after insert) {
    
    List<Event> elist = new List<Event>();
    
    for (Contact c : Trigger.new) {
         Event e = new Event(
            Subject = 'New Contact Meeting',
            StartDateTime = DateTime.now(),  
            EndDateTime = DateTime.now().addHours(3),  
            WhoId = c.Id 
        );
        
        elist.add(e);
    }
    

    if (!elist.isEmpty()) {
        insert elist;
    }
}