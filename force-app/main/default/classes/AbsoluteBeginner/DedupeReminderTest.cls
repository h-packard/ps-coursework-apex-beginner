@isTest
public class DedupeReminderTest {
    @isTest static void createDedupeReminderCaseByCreatingAccount() {
        Account acc = new Account();

        acc.Name = 'Test acc';
        
        insert acc;

    }
}