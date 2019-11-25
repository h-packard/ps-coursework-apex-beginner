trigger ComparableOpp on Opportunity (after insert) {
    List<Opportunity> compOppList = new List<Opportunity>();

    for (Opportunity opp : Trigger.new) {
        Decimal lowerTenPercent = 0.9 * opp.Amount;
        Decimal upperTenPercent = 1.1 * opp.Amount;
        String industry = opp.Account.Industry;
        Date withinOneYear = Date.today().addYears(-1);

    List<Opportunity> comparableOppList = [SELECT Id, Name, Amount
                                            FROM Opportunity
                                            WHERE Amount >= :lowerTenPercent
                                            AND Amount <= :upperTenPercent
                                            AND Account.Industry = :industry
                                            AND StageName = 'Closed Won'
                                            AND CloseDate > :withinOneYear
                                            AND Owner.Position_Start_Date__c < :withinOneYear
                                            AND Id != :opp.Id];
    if ( !comparableOppList.isEmpty() ) {
        for ( Opportunity compOpp : comparableOppList ) {
            Comparable__c junctionObj = new Comparable__c();
            junctionObj.Base_Opportunity__c = opp.Id;
            junctionObj.Comparable_Opportunity__c = compOpp.Id;

            compOppList.add(compOpp);
        }
    }

    insert compOppList;
    }

}