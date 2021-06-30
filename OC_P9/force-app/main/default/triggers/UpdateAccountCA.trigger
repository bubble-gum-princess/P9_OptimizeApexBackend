trigger UpdateAccountCA on Order (after update) {

    List<Order> listOrdered = new List<Order>();
    
    for (integer i=0; i< trigger.new.size(); i++) {
        Order newOrder = trigger.new[i];
        if (newOrder.Status == 'Ordered') {
            listOrdered.add(newOrder);
        }
    }

    AccountService.updateCAFromOrders(listOrdered);

}