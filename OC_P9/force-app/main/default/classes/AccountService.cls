public with sharing class AccountService {

    public static void updateChiffreAffaire(List<Account> accounts){
        Set<Id> setAccountIds = (new Map<Id,Account>(accounts)).keySet();
        list<Order> listOrders =  [SELECT Id, TotalAmount,AccountId FROM Order];
       
		for(Account myAccount : accounts){
			myAccount.Chiffre_d_affaire__c = 0;
           for(Order o : listOrders){
               if(o.AccountId == myAccount.Id){
                   myAccount.Chiffre_d_affaire__c = myAccount.Chiffre_d_affaire__c + o.TotalAmount;
               }                   
           }
       }


        update accounts;
    }

}
        
