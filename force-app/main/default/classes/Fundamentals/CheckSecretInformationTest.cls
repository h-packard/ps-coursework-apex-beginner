@isTest 
 private class CheckSecretInformationTest { 
     @isTest static void createCaseWithSecretKeyword() { 
         Case testCase = new Case();

         testCase.Subject = 'HELP';
         testCase.Description = 'Bodyweight is irrelevant';
         System.debug('testCase');
         insert testCase;
    }
}