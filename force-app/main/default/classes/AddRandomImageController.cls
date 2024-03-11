public with sharing class AddRandomImageController {
    @AuraEnabled
    public static void addRandomImg(Id opportunityId) {
        // Call the future method to perform the web service callout and attachment creation asynchronously
        addRandomImageFuture(opportunityId);
    }
    
    @Future(callout=true)
    public static void addRandomImageFuture(Id opportunityId) {
        try { 
            HttpRequest req = new HttpRequest();
            req.setEndpoint('https://api.unsplash.com/photos/random/?client_id=Idv049JU0ppULKmRclO9_D2H-3hZGog8Esyb-_ittTg');
            req.setMethod('GET');  
            Http http = new Http();
            HttpResponse res = http.send(req); 
                  if (res.getStatusCode() == 200) {
                 Map<String, Object> jsonResults = (Map<String, Object>) JSON.deserializeUntyped(res.getBody());
                System.debug(jsonResults);
                Map<String, Object> Results = (Map<String, Object>) jsonResults.get('urls');
                object smallImage = Results.get('small');
                System.debug(smallImage);
                 HTTP h1 = new HTTP();

                HttpRequest imageRequest = new HttpRequest();
                imageRequest.setEndpoint(string.valueOf(smallImage));
                imageRequest.setMethod('GET');
                HTTPResponse imageResponse = h1.send(imageRequest); 
                String base64ImageData = EncodingUtil.base64Encode(imageResponse.getBodyAsBlob());
                 System.debug(base64ImageData);
                //  Attachment attc =  new Attachment();
                // attc.Name = 'Random Image from API.jpeg';
                // attc.Body = Blob.valueOf(base64ImageData);
                // System.debug(attc.Body);
                // attc.ContentType = 'image/jpeg';        
                // attc.ParentId = opportunityId;
                // insert attc;
                ContentVersion file = new ContentVersion();
                file.Title = 'Random Image';
                file.PathOnClient = 'file_' + Datetime.now().getTime() + '.jpeg';
                file.VersionData = EncodingUtil.base64Decode(base64ImageData);
                file.Origin = 'H';
                insert file; 
                ContentDocumentLink cdl = new ContentDocumentLink();
                cdl.ContentDocumentId = [SELECT ContentDocumentId FROM ContentVersion WHERE Id = :file.Id].ContentDocumentId;
                cdl.LinkedEntityId = opportunityId;
                cdl.ShareType = 'V'; 
                insert cdl;
                system.debug('Attachment added to the Opportunity record!');
                 
        } else { 
                System.debug('Non-200 response received: ' + res.getStatusCode() + ' ' + res.getStatus());
                throw new CalloutException('Non-200 response received: ' + res.getStatusCode() + ' ' + res.getStatus());
            }
        } catch (Exception e) { 
            System.debug('Exception occurred: ' + e.getMessage());
            throw new CalloutException('Exception occurred: ' + e.getMessage());
        }
    }
}
