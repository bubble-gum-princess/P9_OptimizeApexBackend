trigger CalculMontantAndUpdateAccountCA on Order(before update, after update) {
    if (Trigger.isUpdate && Trigger.isBefore) {
        List<Order> listOrders = new List<Order>(Trigger.new);

        OrderService.calculNetAmount(listOrders);
    } else if (Trigger.isUpdate && Trigger.isAfter) {
        List<Order> orders = new List<Order>(Trigger.new);
        OrderService.calculCA(Trigger.oldMap, orders);
    }
}
