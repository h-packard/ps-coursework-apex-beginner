@isTest 
 private class LeadingCompetitorTest { 
     @isTest static void createOppWithCompetitors() { 
         Opportunity opp = new Opportunity();
         opp.Name = 'Big Deal';
         opp.CloseDate = Date.today();
         opp.StageName = 'Prospecting';

         opp.Competitor_1_Price__c = 5000;
         opp.Competitor_2_Price__c = 10000;
         opp.Competitor_3_Price__c = 20000;

         opp.Competitor_1__c = 'Amazon';
         opp.Competitor_2__c = 'Google';
         opp.Competitor_3__c = 'Yahoo!';

         insert opp;
         
    }
}
