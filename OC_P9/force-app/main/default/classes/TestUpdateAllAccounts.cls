@isTest
private class TestUpdateAllAccounts {
    @TestSetup
    static void Setup() {
        TestUtils.LoadData(200, 'Ordered');
    }

    @isTest
    public static void test() {
        Test.startTest();
        UpdateAllAccounts uca = new UpdateAllAccounts();
        Id batchId = Database.executeBatch(uca);
        Test.stopTest();
        // after the testing stops, assert records were updated properly
        Account a = [SELECT chiffre_d_affaire__c FROM Account LIMIT 1];
        System.assertEquals(150 * 10 + 20 * 1000, a.chiffre_d_affaire__c);
    }
}
