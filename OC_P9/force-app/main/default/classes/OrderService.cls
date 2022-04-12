public with sharing class OrderService {
    public static AggregateResult[] getOrdersTotalAmountByCommercial() {
        return [
            SELECT SUM(TotalAmount) total, createdBy.name username
            FROM Order
            WHERE Status = 'Ordered'
            GROUP BY createdBy.name
        ];
    }
    public static void calculNetAmount(List<Order> listOrders) {
        for (Order newOrder : listOrders) {
            newOrder.NetAmount__c =
                newOrder.TotalAmount -
                (newOrder.ShipmentCost__c == null ? 0 : newOrder.ShipmentCost__c);
        }
    }
    public static void calculCA(Map<Id, Order> oldOrders, List<Order> newOrders) {
        List<Account> listacc = new List<Account>();
        Map<Id, Order> mapAccountIdOrder = new Map<Id, Order>();
        //List<Order> Orders = new List<Order>(trigger.new);
        for (Order newOrder : newOrders) {
            if (oldOrders.get(newOrder.Id).status != 'Ordered' && newOrder.status == 'Ordered') {
                mapAccountIdOrder.put(newOrder.AccountId, newOrder);
            }
        }

        if (mapAccountIdOrder.size() > 0) {
            listacc = [
                SELECT Id, Chiffre_d_affaire__c
                FROM Account
                WHERE Id IN :mapAccountIdOrder.keySet()
            ];

            for (Account acc : listacc) {
                acc.Chiffre_d_affaire__c =
                    (acc.Chiffre_d_affaire__c == null ? 0 : acc.Chiffre_d_affaire__c) +
                    mapAccountIdOrder.get(acc.Id).TotalAmount;
            }

            update listacc;
        }
    }
}
