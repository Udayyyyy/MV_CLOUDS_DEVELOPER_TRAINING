trigger Nine on Account (after insert) {
    
    for(Account a:trigger.new){
    Approval.ProcessSubmitRequest req1 = new Approval.ProcessSubmitRequest();
    req1.setComments('Submitting request for approval.');
    req1.setObjectId( a.id );
    req1.setSubmitterId( UserInfo.getUserId() );
    req1.setProcessDefinitionNameOrId('accapp');

Approval.process(req1);

}
}