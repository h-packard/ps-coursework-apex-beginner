@isTest 
 private class SetUpOpportunityTeamTest { 

     @isTest static void noManager() { 
        User aUser = new User();
        aUser.Alias = 'Test User';
        aUser.Email = 'Test@Email.com';
        aUser.LastName = 'TestLastName';
        aUser.Username = 'aUser' + Math.Random() + '@email.com';
        aUser.ManagerId = null;
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
        User aUser = new User();
        aUser.Alias = 'Test User';
        aUser.Email = 'Test@Email.com';
        aUser.LastName = 'TestLastName';
        aUser.Username = 'aUser' + Math.Random() + '@email.com';
        aUser.ManagerId = UserInfo.getUserId();
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
                                                WHERE OpportunityId = :opp.Id
                                                AND UserId = :aUser.Id
                                                AND TeamMemberRole = 'Sales Rep'];

        System.assertEquals(1, oppMember.size());      
        }
}