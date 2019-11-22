trigger DoNotAllowSlaChangesWithOpenCases on Account (before update) {
    //find the accts open cases
    List<Account> accountWithCases = [SELECT Id, 
                                            (SELECT Id
                                            FROM Cases
                                            WHERE IsClosed = false
                                            LIMIT 1)
                                        FROM Account
                                        WHERE Id IN :Trigger.new];
    //check if the accts sla field is changed
    for (Account acc : accountWithCases) {
        String oldSlaValue = Trigger.oldMap.get(acc.Id).SLA__c;
        String newSlaValue = Trigger.newMap.get(acc.Id).SLA__c;

        //Get Trigger.new version of acct
        Account accInTriggerNew = Trigger.newMap.get(acc.Id);

        Boolean isAccSlaChanged = oldSlaValue != newSlaValue;

        //Check if open cases 
        Boolean accHasOpenCases = acc.Cases.size() > 0;

        //if sla is changed and there are open cases, show error

        if (isAccSlaChanged && accHasOpenCases) {
            accInTriggerNew.SLA__c.addError('Please don\'t change SLA when there are open cases!');
        }
    }

}