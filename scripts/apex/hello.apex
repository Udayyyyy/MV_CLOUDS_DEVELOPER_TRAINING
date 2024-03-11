String searchkey='availabe';
List<Account> accounts = [SELECT Id, Name, (SELECT Id, Name FROM Contacts) FROM Account WHERE Name LIKE :searchkey];
    System.debug(accounts);