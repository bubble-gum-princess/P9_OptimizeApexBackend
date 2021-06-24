trigger CalculMontant on Order (before update) {

	for(Order newOrder: trigger.new) {
		newOrder.Net_Amount__c = newOrder.TotalAmount - newOrder.Shipment_Cost__c;
	}
}