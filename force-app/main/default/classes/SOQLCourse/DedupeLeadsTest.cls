@isTest 
 private class DedupeLeadsTest { 
     @isTest static void createLeadNoDupes() { 
        Lead aLead = new Lead();
        aLead.FirstName = 'TestFirst';
        aLead.LastName = 'TestLast';
        aLead.Email = 'TestEmail@email.com';
        aLead.Company = 'TestCompany';
        aLead.Description = 'This is just a test';
        aLead.OwnerId = UserInfo.getUserId();

        insert aLead;

        Lead updatedLead = [SELECT OwnerId, Description
                            From Lead
                            WHERE Id = :aLead.Id];

        System.assertEquals(UserInfo.getUserId(), updatedLead.OwnerId);
        System.assertEquals(aLead.Description, updatedLead.Description);
    }
     @isTest static void createLeadMultipleDupes() { 
        Contact contactOne = new Contact();
        Contact contactTwo = new Contact();
        List<Contact> dupeContacts = new List<Contact>();
        
        contactOne.FirstName = 'TestFirst';
        contactOne.LastName = 'TestLast';
        contactOne.Email = 'TestEmail@email.com';
        dupeContacts.add(contactOne);

        contactTwo.FirstName = 'TestFirst';
        contactTwo.LastName = 'TestLast';
        contactTwo.Email = 'TestEmail@email.com';
        dupeContacts.add(contactTwo);

        insert dupeContacts;

        Lead aLead = new Lead();
        aLead.FirstName = 'TestFirst';
        aLead.LastName = 'TestLast';
        aLead.Email = 'TestEmail@email.com';
        aLead.Company = 'TestCompany';
        aLead.Description = 'This is just a test';
        aLead.OwnerId = UserInfo.getUserId();

        insert aLead;

        Lead updatedLead = [SELECT OwnerId, Description
                            From Lead
                            WHERE Id = :aLead.Id];

        Group dataQualityQueue = [SELECT Id
                                    FROM Group
                                    WHERE DeveloperName = 'Data_Quality'
                                    LIMIT 1];

        System.assertEquals(dataQualityQueue.Id, updatedLead.OwnerId);
        System.assert(updatedLead.Description.contains(contactOne.Id));
        System.assert(updatedLead.Description.contains(contactTwo.Id));

    }
}
