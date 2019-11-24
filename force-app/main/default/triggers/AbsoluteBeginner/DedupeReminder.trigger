trigger DedupeReminder on Account (after insert) {
    for (Account acc : Trigger.new) {
        Case c = new Case();
        c.OwnerId = '0056g000000cT9yAAE';
        c.Subject = 'Remember to dedupe this account';
        c.AccountId = acc.Id;
        c.Status = 'New';
        c.Origin = 'Web';
    }
}