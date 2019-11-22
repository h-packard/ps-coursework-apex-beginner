@isTest
public class HelloWorldTest {
    @isTest static void updateLead() {
        Lead myLead = new Lead();
        myLead.LastName = 'TestLead';
        myLead.Company = 'Test Company';
        insert myLead;

        myLead.Company = 'Test Company 2';
        update myLead;
    }
}
