global class UpdateAccounts implements Database.Batchable<sObject>{
    
    global Database.QueryLocator start(Database.BatchableContext info){ 
        //Requeter seulement les comptes qui ont au moins une commande avec le Status 'Ordered'
        return Database.getQueryLocator('SELECT Id, Chiffre_d_affaire__c, '
        + '(SELECT id from Orders Where Status=\'Ordered\') '
        + 'FROM Account');
 
    }
     
    global void execute(Database.BatchableContext info, List<Account> scope) {
        AccountService.updateCAFromAccounts(scope);
    }    
     
    global void finish(Database.BatchableContext info){     
        
    } 
 }