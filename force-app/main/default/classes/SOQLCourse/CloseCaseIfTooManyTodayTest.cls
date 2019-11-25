@isTest 
 private class CloseCaseIfTooManyTodayTest { 
     @isTest static void createCaseToday() { 
        Case aCase = new Case();

        aCase.Reason = 'Test Case';

        insert aCase;

        Case findACase = [SELECT Status
                         FROM Case
                         WHERE Reason = :aCase.Reason];

        System.assertEquals(findACase.Status, 'New');
    }
    
    @isTest static void moreThanTwoContactsWithCaseToday() { 
        
        Contact aContact = new Contact();
        aContact.LastName = 'Test Contact';
        insert aContact;

        Contact findAContact = [SELECT Id
                                FROM Contact
                                WHERE LastName = :aContact.LastName];

        Case testContactCaseOne = new Case();
        testContactCaseOne.Reason = 'Test Contact Case One';
        testContactCaseOne.ContactId = findAContact.Id;
        insert testContactCaseOne;        
        
        Case testContactCaseTwo = new Case();
        testContactCaseTwo.Reason = 'Test Contact Case Two';
        testContactCaseTwo.ContactId = findAContact.Id;
        insert testContactCaseTwo;

        Case aCase = new Case();
        aCase.Reason = 'Test Case';
        aCase.ContactId = findAContact.Id;
        insert aCase;

        Case findACase = [SELECT Status
                         FROM Case
                         WHERE Reason = :aCase.Reason];


        System.assertEquals(findACase.Status, 'Closed');    
    }     
    
    @isTest static void moreThanThreeAccountsWithCaseToday() { 
        Account anAccount = new Account();
        anAccount.Name = 'Test Account';
        insert anAccount;

        Account findAnAccount = [SELECT Id
                                FROM Account
                                WHERE Name = :anAccount.Name];

        Case testAccountCaseOne = new Case();
        testAccountCaseOne.Reason = 'Test Account Case One';
        testAccountCaseOne.AccountId = findAnAccount.Id;
        insert testAccountCaseOne;        
        
        Case testAccountCaseTwo = new Case();
        testAccountCaseTwo.Reason = 'Test Account Case Two';
        testAccountCaseTwo.AccountId = findAnAccount.Id;
        insert testAccountCaseTwo;

        Case testAccountCaseThree = new Case();
        testAccountCaseThree.Reason = 'Test Account Case Three';
        testAccountCaseThree.AccountId = findAnAccount.Id;
        insert testAccountCaseThree;

        Case aCase = new Case();
        aCase.Reason = 'Test Case';
        aCase.AccountId = findAnAccount.Id;
        insert aCase;

        Case findACase = [SELECT Status
                         FROM Case
                         WHERE Reason = :aCase.Reason];


        System.assertEquals(findACase.Status, 'Closed');    
    }
}