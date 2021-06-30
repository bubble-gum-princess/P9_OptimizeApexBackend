public with sharing class AccountService {

    public static void updateCAFromAccounts(List<Account> listAccounts) {
		for (Account acc : listAccounts) {
            calculateCA(acc, acc.Orders);
        }
       update listAccounts;
    }

    public static void updateCAFromOrders(List<Order> listOrders) {
        Set<Id> setAccountIds = new Set<Id>();
        for (Order o : listOrders) {
            setAccountIds.add(o.AccountId);
        }
        List<Account> listAccounts = [SELECT Id, Chiffre_d_affaire__c
                                        FROM Account  
                                        WHERE Id in :setAccountIds ];
    
        for (Account acc : listAccounts) {
            AccountService.calculateCA(acc, listOrders);
        }                                  

        update listAccounts;
    }

    public static void calculateCA(Account acc, List<Order> listOrdered) {
        for (Order o : listOrdered) {
            if (o.AccountId == acc.id) {
                acc.Chiffre_d_affaire__c += o.TotalAmount;
            }
        }
    }
    
}
