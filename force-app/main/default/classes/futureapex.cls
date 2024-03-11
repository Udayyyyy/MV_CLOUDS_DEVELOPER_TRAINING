public class futureapex {

    @future(callout=true)
    public static void randomimg(ID opportunityID){
        
        Http http=new Http();
        HttpRequest req= new HttpRequest();
        req.setMethod('GET');
        req.setHeader('Authorization','bJGFsvkjOn8Wx-w1vMMU6YEy6kejDi3wZeHvY9S28Dk');
        req.setEndpoint('https://api.unsplash.com/photos/random');
        HttpResponse res=http.send(req);
        
     	system.debug('status code is '+res.getStatusCode());
        
        if(res.getStatusCode()==200){
        Map<String, Object> jsonResponse = (Map<String, Object>)JSON.deserializeUntyped(res.getBody());
            String imageUrl = (String)jsonResponse.get('urls');
        system.debug('success');   
           
            Attachment atm=new Attachment();
            atm.ParentId='0065j00001aYEmhAAG';
            atm.Body=Blob.valueOf(imageUrl);
            atm.Name='Random_Image.jpeg';
            atm.ContentType='image/jpeg';
            insert atm;
        }
    }
}