trigger LeadingCompetitor on Opportunity (before insert, before update) {
    for ( Opportunity opp : Trigger.new ) {
        List<Decimal> competitorPrices = new List<Decimal>();
        competitorPrices.add(opp.Competitor_1_Price__C);
        competitorPrices.add(opp.Competitor_2_Price__C);
        competitorPrices.add(opp.Competitor_3_Price__C);
    
        List<String> competitors = new List<String>();
        competitors.add(opp.Competitor_1__c);
        competitors.add(opp.Competitor_2__c);
        competitors.add(opp.Competitor_3__c);

        Decimal lowestPrice = competitorPrices.get(0);
        Decimal highestPrice = competitorPrices.get(0);
        String mostExpensiveCompetitor, leadingCompetitor;        

        for (Integer i = 0; i < competitors.size(); i++ ) {
            if (lowestPrice >= competitorPrices.get(i)) {
                lowestPrice = competitorPrices.get(i);
                leadingCompetitor = competitors.get(i);
            } 
            
            if (highestPrice <= competitorPrices[i]) {
                highestPrice = competitorPrices[i];
                mostExpensiveCompetitor = competitors[i];
            }

        opp.Leading_Competitor__c = leadingCompetitor;
        opp.Most_Expensive_Competitor__c = mostExpensiveCompetitor;
        }
    }
}