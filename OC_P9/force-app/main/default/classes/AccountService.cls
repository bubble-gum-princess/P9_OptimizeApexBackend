public with sharing class AccountService {
    public static void updateTurnover(List<Account> accounts) {
        for (Account myAccount : accounts) {
            myAccount.Chiffre_d_affaire__c = 0;
            for (Order o : myAccount.orders) {
                if (o.Status == 'Ordered') {
                    myAccount.Chiffre_d_affaire__c = myAccount.Chiffre_d_affaire__c + o.TotalAmount;
                }
            }
        }

        update accounts;
    }
}
