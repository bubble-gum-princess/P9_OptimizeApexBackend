trigger CalculMontantAndUpdateAccountCA on Order (before update,after update) {
	if (trigger.isUpdate){
		if(trigger.isBefore){
			for (Order newOrder : trigger.new) {
				newOrder.NetAmount__c = newOrder.TotalAmount - (newOrder.ShipmentCost__c == null ? 0 : newOrder.ShipmentCost__c);
				System.debug('isBefore '+newOrder);
				System.debug('isBefore '+newOrder.NetAmount__c);
			}
			
		}
		else if(trigger.isAfter){
   			List<Account> listacc = new List<Account>();
            
            Map<Id, Order> oldOrders = new Map<Id, Order>(trigger.old);
            Map<Id,Order> mapAccountIdOrder = new Map<Id,Order>(); 
            for(Order newOrder : trigger.new) {
                Order oldOrder = oldOrders.get(newOrder.id);
                boolean statusToOrderedChanged = oldOrder.status != 'Ordered' && newOrder.status == 'Ordered';
                if (statusToOrderedChanged) {
                    mapAccountIdOrder.put(newOrder.AccountId, newOrder);
                }
            }
            
            if (mapAccountIdOrder.size() > 0) {
                listacc = [SELECT Id, Chiffre_d_affaire__c FROM Account WHERE Id IN :mapAccountIdOrder.keySet()];

                for(Account acc : listacc){
                    acc.Chiffre_d_affaire__c = (acc.Chiffre_d_affaire__c == null ? 0 : acc.Chiffre_d_affaire__c)  + mapAccountIdOrder.get(acc.Id).TotalAmount;
                }

                update listacc;
            }
		}
	}



	

}