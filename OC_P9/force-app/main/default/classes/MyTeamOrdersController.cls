public without sharing class MyTeamOrdersController {
    public AggregateResult[] getSumOrders() {
        return OrderService.getOrdersTotalAmountByCommercial();
    }
}
