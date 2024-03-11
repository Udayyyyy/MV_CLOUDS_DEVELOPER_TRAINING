public class AccountOptions {
    public List<Account> acclst { get; set; }
    public List<Account> accconts1 { get	; set; }
    public Id selectedAccountId { get; set; }
    
    public AccountOptions (){
        acclst = [SELECT Id, Name FROM Account];
    }
    
    public PageReference selacc() {
        String accountId = ApexPages.currentPage().getParameters().get('conlst');
        if (String.isNotBlank(accountId)) {
            accconts1 = [SELECT Id, Name, (SELECT Name, StageName FROM Opportunities) FROM Account WHERE Id = :accountId];
        } else {
            accconts1 = new List<Account>();
        }
        return null;
    }
}