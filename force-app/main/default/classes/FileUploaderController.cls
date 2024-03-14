public class FileUploaderController {
    
    @AuraEnabled
    public static List<String> uploadFiles(List<Map<String, String>> fileDataList, String recordId) {
        List<String> contentDocumentLinkIds = new List<String>();
        for (Map<String, String> fileData : fileDataList) {
            String contentDocumentLinkId = uploadFile(fileData.get('base64'), fileData.get('filename'), recordId);
            if (contentDocumentLinkId != null) {
                contentDocumentLinkIds.add(contentDocumentLinkId);
            }
        }
        return contentDocumentLinkIds;
    }

    private static String uploadFile(String base64, String filename, String recordId) {
        ContentVersion cv = createContentVersion(base64, filename);
        if (cv == null) { return null; }
        ContentDocumentLink cdl = createContentLink(cv.Id, recordId);
        if (cdl == null) { return null; }
        return cdl.Id;
    }
   
    private static ContentVersion createContentVersion(String base64, String filename) {
        ContentVersion cv = new ContentVersion();
        cv.VersionData = EncodingUtil.base64Decode(base64);
        cv.Title = filename;
        cv.PathOnClient = filename;
        try {
            insert cv;
            return cv;
        } catch(DMLException e) {
            System.debug(e);
            return null;
        }
    }
     
    private static ContentDocumentLink createContentLink(String contentVersionId, String recordId) {
        if (contentVersionId == null || recordId == null) { return null; }
        ContentDocumentLink cdl = new ContentDocumentLink();
        cdl.ContentDocumentId = [
            SELECT ContentDocumentId 
            FROM ContentVersion 
            WHERE Id =: contentVersionId
        ].ContentDocumentId;
        cdl.LinkedEntityId = recordId; 
        cdl.ShareType = 'V';
        try {
            insert cdl;
            return cdl;
        } catch(DMLException e) {
            System.debug(e);
            return null;
        }
    }
}
