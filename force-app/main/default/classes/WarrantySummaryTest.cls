@isTest
public class WarrantySummaryTest {
    @isTest static void createWarrantySummaryField() {
        Case myCase = new Case();
        myCase.Product_Purchase_Date__c = Date.today();
        myCase.CreatedDate = Date.today();
        myCase.Status = 'New';
        myCase.Origin = 'Web';
        myCase.Product_Total_Warranty_Days__c = 365;
        myCase.Product_Has_Extended_Warranty__c = true;

        insert myCase;

    }
}