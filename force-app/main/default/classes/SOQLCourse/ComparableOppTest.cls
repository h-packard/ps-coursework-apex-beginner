@isTest 
 private class ComparableOppTest { 
     @isTest static void noComparableOpps() { 
        Account acc = new Account();
        acc.Name = 'Test Company';
        acc.Industry = 'Test Industry';
        insert acc;
        
        Opportunity opp = new Opportunity();
        opp.Name = 'Test Company';
        opp.AccountId = acc.Id;
        opp.Amount = 10000;
        opp.StageName = 'Prospecting';
        opp.CloseDate = Date.today();
        insert opp;

        List<Comparable__c> comparables = [SELECT Id
                                        FROM Comparable__c
                                        WHERE Base_Opportunity__c = :opp.Id];

        System.assertEquals(0, comparables.size());
    }
     @isTest static void multipleComparableOpps() {
        Account acc = new Account();
        acc.Name = 'Test Company';
        acc.Industry = 'Test Industry';
        insert acc;
        
        Profile p = [SELECT Id FROM Profile WHERE Name='Standard User'];
        
        User aUser = new User();
        aUser.Alias = 'TestUser';
        aUser.Email = 'Test@Email.com';
        aUser.Position_Start_Date__c = Date.today().addDays(-700);
        aUser.LastName = 'TestLastName';
        aUser.Username = 'aUser' + Math.Random() + '@email.com';
        aUser.TimeZoneSidKey = 'America/New_York';
        aUser.LocaleSidKey = 'en_US';
        aUser.EmailEncodingKey = 'UTF-8'; 
        aUser.ProfileId = p.Id; 
        aUser.LanguageLocaleKey = 'en_US';

        insert aUser;

        Opportunity oppCompOne = new Opportunity();
        oppCompOne.Name = 'Test Company';
        oppCompOne.AccountId = acc.Id;
        oppCompOne.Amount = 10000;
        oppCompOne.StageName = 'Closed Won';
        oppCompOne.CloseDate = Date.today().addDays(-1);
        insert oppCompOne;
        
        Opportunity oppCompTwo = new Opportunity();
        oppCompTwo.Name = 'Test Company';
        oppCompTwo.AccountId = acc.Id;
        oppCompTwo.Amount = 10000;
        oppCompTwo.StageName = 'Closed Won';
        oppCompTwo.CloseDate = Date.today().addDays(-10);
        insert oppCompTwo;

        Opportunity opp = new Opportunity();
        opp.Name = 'Test Company';
        opp.AccountId = acc.Id;
        opp.Amount = 10000;
        opp.StageName = 'Prospecting';
        opp.CloseDate = Date.today();
        insert opp;

        List<Comparable__c> comparables = [SELECT Id
                                        FROM Comparable__c
                                        WHERE Base_Opportunity__c = :opp.Id
                                        ORDER BY Comparable_Opportunity__r.CloseDate DESC];
        System.debug(comparables);
        System.assertEquals(oppCompOne.Id, comparables[0].Comparable_Opportunity__c);
        System.assertEquals(oppCompTwo.Id, comparables[1].Comparable_Opportunity__c);
    }
}
