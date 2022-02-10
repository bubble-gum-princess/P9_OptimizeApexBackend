@isTest
private class TestCalculMontantAndUpdateAccount {
    static final integer ACCOUNT_CA = 21500;
    static final integer SHIPMENTCOST = 50;
    static final integer ORDER_NET_AMOUNT = ACCOUNT_CA - SHIPMENTCOST;

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
                status='Draft', Pricebook2Id = pricebookId, ShipmentCost__c = SHIPMENTCOST);
        insert o1;

        OrderItem oi1 = new OrderItem (OrderId = o1.Id, PricebookEntryId = pbe.Id, Quantity=10, UnitPrice = 150);
        insert oi1;
        OrderItem oi2 = new OrderItem (OrderId = o1.Id, PricebookEntryId = pbe.Id, Quantity=20, UnitPrice = 1000);
        insert oi2; 
        
    }    

    @isTest public static void before_calcul_field_netamount() {

        Test.startTest();

        Order orderEtatAvantTrigger = [SELECT status FROM Order LIMIT 1];

        orderEtatAvantTrigger.EffectiveDate = System.today();
        Database.SaveResult RS = Database.update(orderEtatAvantTrigger, true);

        Test.stopTest();
        
        Order orderEtatbeforeTrigger = [SELECT NetAmount__c, TotalAmount FROM Order limit 1];

        System.assert(RS.isSuccess());
        System.assertEquals(ORDER_NET_AMOUNT, orderEtatbeforeTrigger.NetAmount__c);
    }

    @isTest public static void after_update_account_ca(){
        Test.startTest();

        Order orderEtatApresTrigger = [SELECT Status, TotalAmount FROM Order LIMIT 1];

        orderEtatApresTrigger.Status= 'Ordered';
        Database.SaveResult RS = Database.update(orderEtatApresTrigger, true);

        Test.stopTest();
        Account acc = [SELECT chiffre_d_affaire__c  FROM Account LIMIT 1 ];
        System.assert(RS.isSuccess());
        System.assertEquals(ACCOUNT_CA, acc.Chiffre_d_affaire__c); 
        System.assertEquals(orderEtatApresTrigger.TotalAmount, acc.Chiffre_d_affaire__c);

    }
           
}
