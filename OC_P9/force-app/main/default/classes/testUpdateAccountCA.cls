@isTest
private class TestUpdateAccountCA {
    @TestSetup
     static void Setup() {
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
                status='Ordered', Pricebook2Id = pricebookId);
        insert o1;

        OrderItem oi1 = new OrderItem (OrderId = o1.Id, PricebookEntryId = pbe.Id, Quantity=10, UnitPrice = 150);
        insert oi1;
        OrderItem oi2 = new OrderItem (OrderId = o1.Id, PricebookEntryId = pbe.Id, Quantity=20, UnitPrice = 1000);
        insert oi2;        
    }

    @isTest public static void test() {
        Test.startTest();
        UpdateAllAccounts uca = new UpdateAllAccounts();
        Id batchId = Database.executeBatch(uca);
        Test.stopTest();
        // after the testing stops, assert records were updated properly
        Account a = [SELECT chiffre_d_affaire__c FROM Account LIMIT 1];
        System.assertEquals(150*10+20*1000,a.chiffre_d_affaire__c);
    }
}
