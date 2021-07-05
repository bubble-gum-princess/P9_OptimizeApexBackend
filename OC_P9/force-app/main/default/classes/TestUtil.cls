@isTest 
public class TestUtil {

    public static final double expectedCA = 21500;

    public static void loadData() {
        Account acc1 = new Account(Name = 'Test Account 1');
        insert acc1;

        Product2 pd1 = new Product2(Name = 'Chemise Verte longue XYX', Family = 'Chemise');
        Insert pd1;
         
        Id pricebookId = Test.getStandardPricebookId();
        //Create the PricebookEntry
        PricebookEntry pbe = new PricebookEntry(
            Pricebook2Id = pricebookId,
            Product2Id = pd1.Id,
            UnitPrice = 1020,
            IsActive = true
        );
        Insert pbe;

        Order o1 = new Order(AccountId = acc1.Id, EffectiveDate=System.today() + 5,
                             status='Draft', Shipment_Cost__c=50,
                             Pricebook2Id = pricebookId);
        insert o1;

        OrderItem oi1 = new OrderItem (OrderId = o1.Id, PricebookEntryId = pbe.Id,
                                       Quantity=10, UnitPrice = 150);
        insert oi1;
        OrderItem oi2 = new OrderItem (OrderId = o1.Id, PricebookEntryId = pbe.Id,
                                       Quantity=20, UnitPrice = 1000);
                                       //20 000 + 1 500
        insert oi2;

    }

    public static void updateOrderStatus() {
        Order o = [select id, status from Order limit 1];
        o.status='Ordered';
        update o;
    }
}
