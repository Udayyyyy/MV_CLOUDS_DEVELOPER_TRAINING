public with sharing class GmailIntegrationController {

    @AuraEnabled
    public static void sendEmail(String to, String subject, String body, String attachmentName, String attachmentBase64) {
        String boundary = 'foo_bar_baz';
        String delimiter = '\r\n--' + boundary + '\r\n';
        String closeDelimiter = '\r\n--' + boundary + '--';

        String mbody = 'Content-Type: multipart/mixed; boundary=' + boundary + '\r\n';
        mbody += 'MIME-Version: 1.0\r\n';
        mbody += 'to: ' + to + '\r\n';
        mbody += 'subject: ' + subject + '\r\n';
        mbody += '\r\n';
 
        mbody += delimiter;
        mbody += 'Content-Type: text/plain\r\n\r\n';
        mbody += body + '\r\n';
 
        if (!String.isBlank(attachmentBase64)) {
            mbody += delimiter;
            mbody += 'Content-Type: application/png\r\n';
            mbody += 'MIME-Version: 1.0\r\n';
            mbody += 'Content-Transfer-Encoding: base64\r\n';
            mbody += 'Content-Disposition: attachment; filename="' + attachmentName + '"\r\n\r\n';
            mbody += attachmentBase64 + '\r\n';
        }
 
        mbody += closeDelimiter;

        HttpRequest req = new HttpRequest();
        req.setEndpoint('callout:Gmail_api/upload/gmail/v1/users/udayradadiya65@gmail.com/messages/send?uploadType=media');
        req.setMethod('POST');
        req.setHeader('Content-Type', 'message/rfc822');
        req.setHeader('Content-Length', mbody.length()+'');
        // req.setHeader('Authorization', 'Bearer ya29.a0Ad52N38zZ1IyhoMUMYpabNzI7CyOD-a3pmDdZoBmXbeYSzlczHE4VnWaBPmONCOU5hdkkv_i_G4UmkFT77pgxODw4OdlCyeCMogZ9EPywbx8fF3ZphPDXl8T640TLr1x-kNv12dnGuWFdtBFXj2v8pzhJbs5N0lQq4AaCgYKAf4SARESFQHGX2Mi4gBhD6ff--GvMAhtECoNww0170'); 
        req.setBody(mbody);

        Http http = new Http();
        HttpResponse res = http.send(req);
        if (res.getStatusCode() == 200) {
            System.debug('Successfully sent the email!');
        } else {
            System.debug('Error sending email: ' + res.getStatusCode() + ' ' + res.getBody());
        }
    }
}