@isTest
private class TestCalculMontantAndUpdateAccount {

     @TestSetup

     static void Setup() {

        TestUtils.LoadData();       
 
        }    

    @isTest public static void before_calcul_field_netamount() {

        Test.startTest();

        Order orderEtatAvantTrigger = [SELECT status FROM Order LIMIT 1];

        orderEtatAvantTrigger.EffectiveDate = System.today();
        Database.SaveResult RS = Database.update(orderEtatAvantTrigger, true);

        Test.stopTest();
        
        Order orderEtatbeforeTrigger = [SELECT NetAmount__c, TotalAmount FROM Order limit 1];

        System.assert(RS.isSuccess());
        System.assertEquals( TestUtils.ORDER_NET_AMOUNT, orderEtatbeforeTrigger.NetAmount__c);
    }

    @isTest public static void after_update_account_ca(){
        Test.startTest();

        Order orderEtatApresTrigger = [SELECT Status, TotalAmount FROM Order LIMIT 1];

        orderEtatApresTrigger.Status= 'Ordered';
        Database.SaveResult RS = Database.update(orderEtatApresTrigger, true);

        Test.stopTest();
        Account acc = [SELECT chiffre_d_affaire__c  FROM Account LIMIT 1 ];
        System.assert(RS.isSuccess());
        System.assertEquals(TestUtils.ACCOUNT_CA, acc.Chiffre_d_affaire__c); 
        System.assertEquals(orderEtatApresTrigger.TotalAmount, acc.Chiffre_d_affaire__c);

    }
           
}
