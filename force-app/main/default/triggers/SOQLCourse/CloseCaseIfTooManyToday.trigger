trigger CloseCaseIfTooManyToday on Case (before insert) {

    for ( Case aCase : Trigger.new ) {
        if (aCase.ContactId != null) {
            List<Case> relatedCasesCon = [SELECT Id
                                        FROM Case
                                        WHERE CreatedDate = TODAY
                                        AND ContactId = :aCase.ContactId];
            if ( relatedCasesCon.size() >= 2 ) {
                aCase.Status = 'Closed';
            }
        }

        if (aCase.AccountId != null) {
            List<Case> relatedCasesAcc = [SELECT Id
                                        FROM Case
                                        WHERE CreatedDate = TODAY
                                        AND AccountId = :aCase.AccountId];
            if ( relatedCasesAcc.size() >= 3 ) {
                aCase.Status = 'Closed';
            }
        }        
    }
}