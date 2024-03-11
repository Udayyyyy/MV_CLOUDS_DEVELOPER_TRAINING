public class ErrorLog {

     
    public static void createExceptionRecord(Exception ex, String className, String methodName) {
        
        Error_Log__c errorLog = new Error_Log__c();

         
        errorLog.Class_Name__c = className;
        errorLog.Exception_Message__c = ex.getMessage();
        errorLog.Line__c = ex.getLineNumber();
        errorLog.Method_Name__c = methodName;
        errorLog.Exception_Type__c = ex.getTypeName();
        errorLog.More_Details__c = 'Additional details can be added here';

        insert errorLog;
    }
}