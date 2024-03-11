public with sharing class CreateContactController {
    @AuraEnabled
    public static Boolean insertcon(String fname,String lname,String phone,String email) {
        Contact con= new Contact();
        con.FirstName=fname;
        con.LastName=lname;
        con.Phone=phone;
        con.Email=email;
        insert con;
        return true;
    }
}