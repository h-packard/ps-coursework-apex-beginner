trigger CheckSecretInformation on Case (before update, after insert) {
        Set<String> secretKeywords = new Set<String>();
        String childCaseSubject = 'Warning! Parent case may contain secret info';
        List<Case> casesWithSecretInfo = new List<Case>();
        List<Case> casesToCreate = new List<Case>();

        secretKeywords.add('Credit Card');
        secretKeywords.add('Social Security');
        secretKeywords.add('SSN');
        secretKeywords.add('Passport');
        secretKeywords.add('Bodyweight');


        for ( Case myCase : Trigger.new ) {
            if ( myCase.Subject != childCaseSubject ) {
                for ( String keyword : secretKeywords ) {
                    if ( myCase.Description != null && myCase.Description.containsIgnoreCase(keyword) ) {
                        casesWithSecretInfo.add(myCase);
                        break;
                    }
                }
            }
        }

        for (Case caseWithSecretInfo : casesWithSecretInfo ) {

            Case childCase = new Case();

            childCase.subject = childCaseSubject;
            childCase.ParentId = caseWithSecretInfo.Id;
            childCase.IsEscalated = true;
            childCase.Priority = 'High';
            childCase.Description = 'At least one of the following keywords were found: ' + secretKeywords;

            casesToCreate.add(childCase);
        }

        insert casesToCreate;


}