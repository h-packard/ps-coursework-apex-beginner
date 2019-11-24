@isTest 
 private class CheckCreateTaskForEveryItemInPicklist { 
     @isTest static void createAccountWithThreeChoices() { 
        Account testAccount = new Account();

        testAccount.Name = 'testAccount';
        testAccount.Choices__c = 'Choice 1;Choice 2;Choice 3';

        insert testAccount;
    }
}