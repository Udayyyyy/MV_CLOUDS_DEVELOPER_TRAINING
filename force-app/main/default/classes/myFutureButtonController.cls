public class myFutureButtonController {
    
    private String opportunityId;

    public myFutureButtonController(ApexPages.StandardController controller) {
        this.opportunityId = ApexPages.CurrentPage().getParameters().get('thisOppId');
        if (opportunityId != null) {
            // Calling the future method
            FutureButtonController(opportunityId); 
        }
    }
    
    // Future method for making callouts asynchronously
    @future(callout=true)
    public static void FutureButtonController(String oppId) {
        try {
            // Making an HTTP callout to get a random image from the Unsplash API
            HTTP h = new HTTP();
            HttpRequest req = new HttpRequest();  
            req.setEndpoint('https://api.unsplash.com/photos/random/?client_id=Idv049JU0ppULKmRclO9_D2H-3hZGog8Esyb-_ittTg');
            req.setMethod('GET');                                        
            HTTPResponse res = h.send(req); 
            
            if (res.getStatusCode() == 200) {
                // Parsing the JSON response to get the image URL
                Map<String, Object> jsonResponse = (Map<String, Object>) JSON.deserializeUntyped(res.getBody());
                Map<String, Object> urls = (Map<String, Object>) jsonResponse.get('urls');
                String imageUrl = (String) urls.get('small');
                
                // Making a callout to download the image
                HTTPRequest imageRequest = new HttpRequest();
                imageRequest.setEndpoint(imageUrl);
                imageRequest.setMethod('GET');
                HTTPResponse imageResponse = new HTTP().send(imageRequest);
                
                if (imageResponse.getStatusCode() == 200) {
                    // Converting the image data to base64 and creating an Attachment
                    String base64ImageData = EncodingUtil.base64Encode(imageResponse.getBodyAsBlob());
                    Attachment attachment = new Attachment();
                    attachment.Name = 'Random Image from Unsplash API';
                    attachment.Body = EncodingUtil.base64Decode(base64ImageData);
                    attachment.ContentType = 'image/jpeg';
                    attachment.ParentId = oppId;
                    insert attachment;
                    System.debug('Attachment added to the Opportunity record!');
                } else {
                    System.debug('Failed to download the image with status code: ' + imageResponse.getStatusCode());
                }
            } else {
                System.debug('Failed to get a random image with status code: ' + res.getStatusCode());
            }
        } catch(Exception e) {
            System.debug('An exception occurred: ' + e.getMessage());
        }
    }
}
