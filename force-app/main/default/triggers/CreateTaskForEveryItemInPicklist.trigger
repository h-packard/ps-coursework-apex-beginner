trigger CreateTaskForEveryItemInPicklist on Account (after insert, after update) {
    List<Account> bulkAccount = new List<Account>();
    for ( Account anAccount : Trigger.new ) {
        List<Task> tasks = new List<Task>();

        if ( anAccount.Choices__c != null ) {
            if (anAccount.Choices__c.contains('Choice 1')) {
                Task task1 = new Task();
                task1.Subject = 'Choice 1';
                task1.WhatId = anAccount.Id;
                tasks.add(task1);
            }
            if (anAccount.Choices__c.contains('Choice 2')) {
                Task task2 = new Task();
                task2.Subject = 'Choice 2';
                task2.WhatId = anAccount.Id;
                tasks.add(task2);
            }
            if (anAccount.Choices__c.contains('Choice 3')) {
                Task task3 = new Task();
                task3.Subject = 'Choice 3';
                task3.WhatId = anAccount.Id;
                tasks.add(task3);
            }
            if (anAccount.Choices__c.contains('Choice 4')) {
                Task task4 = new Task();
                task4.Subject = 'Choice 4';
                task4.WhatId = anAccount.Id;
                tasks.add(task4);            
            }
            if (anAccount.Choices__c.contains('Choice 5')) {
                Task task5 = new Task();
                task5.Subject = 'Choice 5';
                task5.WhatId = anAccount.Id;
                tasks.add(task5);            
            }

            insert tasks;
        }
    }
}