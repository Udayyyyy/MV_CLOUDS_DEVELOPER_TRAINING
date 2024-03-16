public with sharing class GmailIntegrationController {

    @AuraEnabled
    public static void sendEmail(String to, String subject, String body) {
        System.debug(to);
        System.debug(subject);
        System.debug(body);
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        email.setToAddresses(new List<String>{to});
        email.setSubject(subject);
        email.setPlainTextBody(body);
 
        String emailJson = JSON.serialize(email);
 
        HttpRequest req = new HttpRequest();
        req.setEndpoint('callout:Gmail_API/gmail/v1/users/udayradadiya65@gmail.com/drafts/send');
        req.setMethod('POST');
        req.setHeader('Content-Type', 'application/json');
        req.setBody(emailJson);

        Http http = new Http();
        HttpResponse res = http.send(req);
 
        if (res.getStatusCode() == 200) {
            System.debug(res.getStatusCode());
            System.debug('Successfully sent the email!');
 

        } else { 
            System.debug(res.getStatusCode());
            System.debug(res.getBody()); 
        }
    }
}
