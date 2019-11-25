trigger DedupeLeads on Lead (before insert) {
    List<Group> dataQualityGroup = [SELECT Id 
                                    FROM Group
                                    WHERE DeveloperName = 'Data_Quality'
                                    LIMIT 1];
    for ( Lead aLead : Trigger.new ) {

        if ( aLead.Email != null && aLead.FirstName != null ) {
            String firstNameInitial = aLead.FirstName.charAt(0) + '%';
            String companyDupe = '%' + aLead.Company + '%';
            List<Contact> dupeContacts = [SELECT Id, FirstName, LastName, Account.Name 
                                                FROM Contact
                                                WHERE Email = :aLead.Email 
                                                AND FirstName LIKE :firstNameInitial
                                                AND LastName = :aLead.LastName
                                                AND Account.Name = :aLead.Company];
        
        
            //find contacts with same email
            if (!dupeContacts.isEmpty()) {
                String dupeMessage = 'Duplicate contact(s) found:\n';

                aLead.OwnerId = dataQualityGroup[0].Id;
            //if same email, assign to data quality queue
            for (Contact aContact : dupeContacts) {
                dupeMessage += aContact.FirstName + ' ' +
                                aContact.LastName + ', ' + 
                                aContact.Account.Name + ' (' +
                                aContact.Id + ')\n';
            }

            aLead.Description = dupeMessage + '\n' + aLead.Description;

            }
        }
    }
}