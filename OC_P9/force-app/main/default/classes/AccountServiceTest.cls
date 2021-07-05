@isTest
private class AccountServiceTest {

    @isTest static void should_calculate_ca() {
        TestUtil.loadData();
        Account acc = [select Chiffre_d_affaire__c from account limit 1];
        List<Order> listOrdered = [select AccountId, status, TotalAmount from Order];
        for (Order o : listOrdered) {
            o.status = 'Ordered';
        }
        AccountService.calculateCA(acc, listOrdered);
        System.assertEquals(TestUtil.expectedCA, acc.Chiffre_d_affaire__c);
    }
}
