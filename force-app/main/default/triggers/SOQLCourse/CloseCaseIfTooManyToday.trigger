trigger CloseCaseIfTooManyToday on Case (before insert) {

    for ( Case aCase : Trigger.new ) {
        Integer contactCounter = 0;
        Integer accountCounter = 0;

        List<Case> relatedCases = [SELECT Id, AccountId, ContactId
                                          FROM Case
                                          WHERE CreatedDate = :Date.today()
                                          AND ContactId = :aCase.ContactId
                                          AND AccountId = :aCase.AccountId];
        
        for ( Case relCase : relatedCases ) {
            if (relCase.ContactId == aCase.ContactId ) {
                contactCounter += 1;
            }

            if (relCase.AccountId == aCase.AccountId ) {
                accountCounter += 1;
            }
            
        }

        if ( accountCounter > 3 || contactCounter > 2 ) {
            aCase.Status = 'Closed';
        }
        
    }
}