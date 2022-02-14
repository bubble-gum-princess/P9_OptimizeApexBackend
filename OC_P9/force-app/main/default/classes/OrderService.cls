public with sharing class OrderService {
    public static AggregateResult[] getOrders() {

        return [SELECT SUM(TotalAmount) total,
                    	createdBy.name username 
                    FROM Order 
                    where Status = 'Ordered' 
                    Group By createdBy.name ];

    }
}
