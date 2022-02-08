trigger CalculMontantAndUpdateAccountCA on Order (before update,after update) {
	if (trigger.isUpdate){
		if(trigger.isBefore){
			for (Order newOrder : trigger.new) {
				newOrder.NetAmount__c = newOrder.TotalAmount - newOrder.ShipmentCost__c;
				System.debug('isBefore '+newOrder);
				System.debug('isBefore '+newOrder.NetAmount__c);
			}
			
		}
		else if(trigger.isAfter){
			set<Id> setAccountIds = new set<Id>();
   			List<Account> listacc = new List<Account>();
    
    		for(Order newOrder : trigger.new) {
       			Account acc = [SELECT Id, Chiffre_d_affaire__c FROM Account WHERE Id =:newOrder.AccountId ];
        		acc.Chiffre_d_affaire__c = acc.Chiffre_d_affaire__c + newOrder.TotalAmount;

				listacc.add(acc);
				System.debug('isAfter '+newOrder);
				System.debug('isAfter '+newOrder.NetAmount__c);
			}
			update listacc;
		}
	}



	

}