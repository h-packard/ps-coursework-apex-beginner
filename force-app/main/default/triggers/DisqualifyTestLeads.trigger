trigger DisqualifyTestLeads on Lead (before insert) {

    for (Lead aLead : Trigger.new) {
        String testFirstName;
        String testLastName = aLead.lastName.toLowerCase();

        if ( aLead.firstName != null ) {
            testFirstName = aLead.firstName.toLowerCase();
            }


        if ((testFirstName != null && testFirstName == 'test') || testLastName == 'test' ) {
            aLead.Status = 'Disqualified';
        } else if ( (testFirstName != null && testFirstName == 'David' ) && testLastName == 'Liu' ) {
            aLead.Status = 'Disqualified';
        }
    }
}