global class UpdateAllAccounts implements Database.Batchable<sObject> {
    global Database.QueryLocator start(Database.BatchableContext info) {
        //Requeter seulement les comptes qui ont au moins une commande avec le Status 'Ordered'
        return Database.getQueryLocator(
            'SELECT Id, chiffre_d_affaire__c,' +
            '(select Id, TotalAmount, Status from Orders where Status=\'Ordered\') FROM Account'
        );
    }

    global void execute(Database.BatchableContext info, List<Account> scope) {
        System.debug('scope size = ' + scope.size());
        AccountService.updateTurnover(scope);
    }

    global void finish(Database.BatchableContext info) {
    }
}
