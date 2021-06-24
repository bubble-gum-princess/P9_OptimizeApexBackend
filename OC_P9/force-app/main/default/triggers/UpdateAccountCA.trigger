trigger UpdateAccountCA on Order (after update) {
	
    set<Id> setAccountIds = new set<Id>();
    for(integer i=0; i< trigger.new.size(); i++){
        Order newOrder= trigger.new[i];
        setAccountIds.add(newOrder.AccountId);
    }

    List<Account> listAccounts = [SELECT Id, Chiffre_d_affaire__c 
                                  FROM Account 
                                  WHERE Id in :setAccountIds ];
    
    for(integer i=0; i< trigger.new.size(); i++){
        Order newOrder= trigger.new[i];
        for (Account acc : listAccounts) {
            acc.Chiffre_d_affaire__c = acc.Chiffre_d_affaire__c + newOrder.TotalAmount;
        }
    }


    update listAccounts;
}