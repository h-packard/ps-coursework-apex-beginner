trigger CreateCounterForAccountPicklist on Account (before insert, before update) {
    List<Account> bulkAccount = new List<Account>();
    for ( Account anAccount : Trigger.new ) {
        Integer counter = 0;

        if ( anAccount.Choices__c != null ) {
            if (anAccount.Choices__c.contains('Choice 1')) {
                counter += 1;
            }
            if (anAccount.Choices__c.contains('Choice 2')) {
                counter += 1;
            }
            if (anAccount.Choices__c.contains('Choice 3')) {
                counter += 1;
            }
            if (anAccount.Choices__c.contains('Choice 4')) {
                counter += 1;
            }
            if (anAccount.Choices__c.contains('Choice 5')) {
                counter += 1;
            }
        }
        anAccount.Counter__c = counter;
        
    }
}