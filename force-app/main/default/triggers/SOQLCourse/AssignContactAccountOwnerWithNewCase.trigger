trigger AssignContactAccountOwnerWithNewCase on Case (after insert) {
//     for (Case aCase : Trigger.new) {
//         //contact owner is whoever created case
//         if ( aCase.ContactId != null ) {
//             Contact aContact = [SELECT Id
//                                 FROM Contact 
//                                 WHERE Id = :aCase.ContactId];
//             aContact.OwnerId = aCase.CreatedById;
//             insert aContact;
//         }
//         if ( aCase.AccountId != null ) {
//             //acc owner is whoever created case on it
//             Account acc = [SELECT Id
//                                 FROM Account 
//                                 WHERE Id = :aCase.AccountId];
//             acc.OwnerId = aCase.CreatedById;
//             insert acc;
//         }
//     }
}