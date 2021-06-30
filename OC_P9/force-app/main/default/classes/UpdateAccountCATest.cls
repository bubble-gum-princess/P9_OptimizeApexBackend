@isTest
private class UpdateAccountCATest {
    @isTest static void LoadData() {
        Account acc1 = new Account(Name = 'Test Account 1');
        insert acc1;

        Product2 pd1 = new Product2(Name = 'Chemise Verte longue XYX', Family = 'Chemise');
        Insert pd1;
 
        //Create the PricebookEntry
        PricebookEntry pbe = new PricebookEntry(
            Pricebook2Id = Test.getStandardPricebookId(),
            Product2Id = pd1.Id,
            UnitPrice = 1020,
            IsActive = true
        );
        Insert pbe;

        Order o1 = new Order(AccountId = acc1.Id);
        insert o1;

        OrderItem oi1 = new OrderItem (OrderId = o1.Id, PricebookEntryId = pbe.Id, Quantity=10, UnitPrice = 150);
        insert oi1;
        OrderItem oi2 = new OrderItem (OrderId = o1.Id, PricebookEntryId = pbe.Id, Quantity=20, UnitPrice = 1000);
        insert oi2;        
    }
/*
    @isTest static void Positive_UpdateAccountCA_Test() {
        LoadData();
        test.startTest();
        // code de test.
        test.stopTest();
        System.assertEquals();
    }
    @isTest static void Negative_UpdateAccountCA_Test() {
        System.assertNotEquals();
    }
    static testMethod void Bulk_UpdateAccountCA_Test(){
        

    }
    */
}