public class ErrorExample {

    public static void mymethod(){
        try{
            integer a;
            integer b = 5*a;
        }
        catch(Exception e){
            ErrorLog.createExceptionRecord(e, 'ErrorExample', 'mymethod');
        }
    }
}