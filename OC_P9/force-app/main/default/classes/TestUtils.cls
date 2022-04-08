public with sharing class TestUtils {
    public static final integer ACCOUNT_CA = 21500;
    public static final integer SHIPMENTCOST = 50;
    public static final integer ORDER_NET_AMOUNT = ACCOUNT_CA - SHIPMENTCOST;
    private static final Id pricebookId = Test.getStandardPricebookId();

    public static void LoadData(integer size, String statusOrder) {
        PricebookEntry pbe = insertPricebook();
        Map<Integer, Account> mapAccounts = new Map<Integer, Account>();
        Map<Integer, Order> mapOrders = new Map<Integer, Order>();
        List<OrderItem> listOrderItems = new List<OrderItem>();

        for (integer i = 0; i < size; i++) {
            mapAccounts.put(i, new Account(Name = 'Test Account ' + i));
        }
        insert mapAccounts.values();

        for (integer i = 0; i < size; i++) {
            Account acc = mapAccounts.get(i);
            mapOrders.put(
                i,
                new Order(
                    AccountId = acc.Id,
                    EffectiveDate = System.today() + 5,
                    status = statusOrder,
                    Pricebook2Id = pricebookId,
                    ShipmentCost__c = TestUtils.SHIPMENTCOST
                )
            );
        }
        insert mapOrders.values();

        for (integer i = 0; i < size; i++) {
            createOrderItems(mapOrders.get(i), pbe, listOrderItems);
        }
        insert listOrderItems;
    }

    private static void createOrderItems(
        Order o,
        PricebookEntry pbe,
        List<OrderItem> listOrderItems
    ) {
        OrderItem oi1 = new OrderItem(
            OrderId = o.Id,
            PricebookEntryId = pbe.Id,
            Quantity = 10,
            UnitPrice = 150
        );
        listOrderItems.add(oi1);
        OrderItem oi2 = new OrderItem(
            OrderId = o.Id,
            PricebookEntryId = pbe.Id,
            Quantity = 20,
            UnitPrice = 1000
        );
        listOrderItems.add(oi2);
    }

    private static PricebookEntry insertPricebook() {
        Product2 pd1 = new Product2(Name = 'Chemise Verte longue XYX', Family = 'Chemise');
        insert pd1;

        //Create the PricebookEntry
        PricebookEntry pbe = new PricebookEntry(
            Pricebook2Id = pricebookId,
            Product2Id = pd1.Id,
            UnitPrice = 1020,
            IsActive = true
        );
        insert pbe;
        return pbe;
    }
}
