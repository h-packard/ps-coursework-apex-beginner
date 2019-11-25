@isTest 
 private class CloseCaseIfTooManyTodayTest { 
     @isTest static void createCaseToday() { 
        Case aCase = new Case();

        aCase.Reason = 'TestCase';

        insert aCase;

        Case findACase = [SELECT Status
                         FROM Case
                         WHERE Reason = :aCase.Reason];

        System.assertEquals('New', findACase.Status);
    }
    
    @isTest static void moreThanTwoCasesOnContactToday() { 
        
        Contact aContact = new Contact();
        aContact.LastName = 'TestContact';
        insert aContact;


        List<Case> testCases = new List<Case>();
        for(Integer i=0; i <4; i++) {
            Case testCase = new Case();
            testCase.ContactId = aContact.Id;
            testCases.add(testCase);        
        }

        insert testCases;


        Case aCase = new Case();
        aCase.ContactId = aContact.Id;
        insert aCase;

        Case findACase = [SELECT Status
                         FROM Case
                         WHERE Id = :aCase.Id];

        System.assertEquals('Closed', findACase.Status);    
    }     
    
    @isTest static void moreThanThreeAccountsWithCaseToday() { 
        Account anAccount = new Account();
        anAccount.Name = 'Test Account';
        insert anAccount;

        List<Case> testCases = new List<Case>();
        for(Integer i=0; i < 5; i++) {
            Case testCase = new Case();
            testCase.AccountId = anAccount.Id;
            testCases.add(testCase);        
        }
        insert testCases;

        Case aCase = new Case();
        aCase.AccountId = anAccount.Id;
        insert aCase;

        Case findACase = [SELECT Status
                         FROM Case
                         WHERE Id = :aCase.Id];

        System.assertEquals('Closed', findACase.Status);    
    }  
}