@isTest 
private class CalculMontantTest {

    @isTest
    static void Positive_CalculMontant_Test() {
        TestUtil.loadData();
        
        test.startTest();
        TestUtil.updateOrderStatus();
        test.stopTest();
        
        System.assertEquals(1, [select count() from Order where status ='Ordered']);
        System.assertEquals(TestUtil.expectedCA - 50, [select Net_Amount__c from Order limit 1][0].Net_Amount__c);
    }
     
}
