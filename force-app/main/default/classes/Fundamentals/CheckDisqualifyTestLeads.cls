@isTest 
 private class CheckDisqualifyTestLeads { 
     @isTest static void createLeadWithNameTest() { 
        
        Lead testLead = new Lead();

        testLead.lastName = 'test';
        testLead.Company = 'Test Company';
        testLead.Status = 'New';

        insert testLead;
    }

    @isTest static void createLeadWithNameDavidLiu() { 
        
        Lead testLead = new Lead();

        testLead.firstName = 'David';
        testLead.lastName = 'Liu';
        testLead.Company = 'Test Company';
        testLead.Status = 'New';

        insert testLead;
    }
}