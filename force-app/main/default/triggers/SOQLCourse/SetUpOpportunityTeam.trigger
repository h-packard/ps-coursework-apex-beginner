trigger SetUpOpportunityTeam on Opportunity (after insert) {

    for ( Opportunity opp : Trigger.new ) {
        List<OpportunityTeamMember> oppTeamList = new List<OpportunityTeamMember>();

        Opportunity oppManager = [SELECT Id, Owner.ManagerId
                                    FROM Opportunity 
                                    WHERE Id = :opp.Id];
                                    
        if ( oppManager.Owner.ManagerId != null ) {
            OpportunityTeamMember oppMember = new OpportunityTeamMember();
            oppMember.UserId = oppManager.Owner.ManagerId;
            oppMember.OpportunityId = opp.Id;
            oppMember.TeamMemberRole = 'Sales Manager';
            oppTeamList.add(oppMember);
        }

        List<User> subUsers = [SELECT Id 
                                FROM User
                                WHERE ManagerId = :opp.Id];
        if ( !subUsers.isEmpty() ) {
            OpportunityTeamMember oppSubMbr = new OpportunityTeamMember();
            oppSubMbr.UserId = subUsers[0].Id;
            oppSubMbr.OpportunityId = opp.Id;
            oppSubMbr.TeamMemberRole = 'Sales Rep';
            oppTeamList.add(oppSubMbr);
        }

        if ( !oppTeamList.isEmpty() ) {
            insert oppTeamList;
        }
    }

}