public class scheduleforaccdesc implements Schedulable{
    
    public void execute(SchedulableContext sc){
        Database.executeBatch(new updateaccdesc());
    }

}