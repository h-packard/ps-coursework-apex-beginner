trigger WarrantySummary on Case (before insert) {
    for (Case myCase : Trigger.new) {
        Date purchasedDate = myCase.Product_Purchase_Date__c;
        DateTime createdDate = myCase.CreatedDate;
        Integer warrantyDays = myCase.Product_Total_Warranty_Days__c.intValue();
        Decimal warrantyPercentage = (purchasedDate.daysBetween(Date.today()) / myCase.Product_Total_Warranty_Days__c).setScale(2);
        Boolean hasExtendedWarranty = myCase.Product_Has_Extended_Warranty__c;

    myCase.Warranty_Summary__c = 
        'Product purchased on ' + purchasedDate + 
        ' and case created on ' + createdDate + '.\n' +
        'Warranty is for ' + warrantyDays + 
        'days and is ' + warrantyPercentage * 100 + '% through its warranty period.\n' +
        'Extended Warranty: ' + hasExtendedWarranty +
        '\n Have a nice day!';
    }
}