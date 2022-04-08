@isTest
private class TestCalculMontantAndUpdateAccount {
    @TestSetup
    static void Setup() {
        TestUtils.LoadData(100, 'Draft');
    }

    @isTest
    public static void before_calcul_field_netamount() {
        Test.startTest();
        //TODO trigger test for 100 orders
        List<Order> listOrderBefore = [SELECT status FROM Order];

        for (Order orderEtatAvantTrigger : listOrderBefore) {
            orderEtatAvantTrigger.EffectiveDate = System.today();
        }
        List<Database.SaveResult> listRS = Database.update(listOrderBefore, true);

        Test.stopTest();

        List<Order> listOrders = [SELECT NetAmount__c, TotalAmount FROM Order];

        for (Database.SaveResult RS : listRS)
            System.assert(RS.isSuccess());

        for (Order orderEtatbeforeTrigger : listOrders) {
            System.assertEquals(TestUtils.ORDER_NET_AMOUNT, orderEtatbeforeTrigger.NetAmount__c);
        }
    }

    @isTest
    public static void after_update_account_ca() {
        Test.startTest();

        List<Order> listOrderBefore = [SELECT Status, TotalAmount FROM Order];

        for (Order orderBefore : listOrderBefore) {
            orderBefore.Status = 'Ordered';
        }
        List<Database.SaveResult> listRS = Database.update(listOrderBefore, true);

        Test.stopTest();
        List<Account> listAccounts = [SELECT chiffre_d_affaire__c FROM Account];

        for (Database.SaveResult RS : listRS)
            System.assert(RS.isSuccess());

        for (Account acc : listAccounts) {
            System.assertEquals(TestUtils.ACCOUNT_CA, acc.Chiffre_d_affaire__c);
        }
    }
}
