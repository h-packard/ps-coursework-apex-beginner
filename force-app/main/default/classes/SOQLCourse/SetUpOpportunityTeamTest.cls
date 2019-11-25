@isTest 
 private class SetUpOpportunityTeamTest { 

     @isTest static void noManager() { 
        Profile p = [SELECT Id FROM Profile WHERE Name='Standard User'];

        User aUser = new User();
        aUser.Alias = 'TestUser';
        aUser.Email = 'Test@Email.com';
        aUser.LastName = 'TestLastName';
        aUser.Username = 'aUser' + Math.Random() + '@email.com';
        aUser.ManagerId = null;
        aUser.TimeZoneSidKey = 'America/New_York';
        aUser.LocaleSidKey = 'en_US';
        aUser.EmailEncodingKey = 'UTF-8'; 
        aUser.ProfileId = p.Id; 
        aUser.LanguageLocaleKey = 'en_US';
        insert aUser; 

        Opportunity opp = new Opportunity();
        opp.Name = 'Test Company';
        opp.Amount = 10000;
        opp.StageName = 'Prospecting';
        opp.CloseDate = Date.today();
        opp.OwnerId = aUser.Id;
        insert opp;   

        List<OpportunityTeamMember> oppMember = [SELECT Id
                                            FROM OpportunityTeamMember
                                            WHERE OpportunityId = :opp.Id];

        System.assertEquals(0, oppMember.size());

        }

     @isTest static void ownerIsManager() {
        Profile p = [SELECT Id FROM Profile WHERE Name='System Administrator'];

        User aUser = new User();
        aUser.Alias = 'TestUser';
        aUser.Email = 'Test@Email.com';
        aUser.LastName = 'TestLastName';
        aUser.Username = 'aUser' + Math.Random() + '@email.com';
        aUser.ManagerId = UserInfo.getUserId();
        aUser.TimeZoneSidKey = 'America/New_York';
        aUser.LocaleSidKey = 'en_US';
        aUser.EmailEncodingKey = 'UTF-8'; 
        aUser.ProfileId = p.Id; 
        aUser.LanguageLocaleKey = 'en_US';
        insert aUser; 

        Opportunity opp = new Opportunity();
        opp.Name = 'Test Company';
        opp.Amount = 10000;
        opp.StageName = 'Prospecting';
        opp.CloseDate = Date.today();
        opp.OwnerId = UserInfo.getUserId();
        insert opp;   

        List<OpportunityTeamMember> oppMember = [SELECT Id
                                                FROM OpportunityTeamMember
                                                WHERE OpportunityId = :opp.Id
                                                AND UserId = :aUser.Id
                                                AND TeamMemberRole = 'Sales Rep'];

        System.assertEquals(1, oppMember.size());      
        }
}