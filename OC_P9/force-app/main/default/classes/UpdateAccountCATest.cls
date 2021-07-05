@isTest
private class UpdateAccountCATest {
    
    @isTest static void Positive_UpdateAccountCA_Test() {
        TestUtil.loadData();
        
        test.startTest();
        TestUtil.updateOrderStatus();
        test.stopTest();
        
        System.assertEquals(1, [select count() from Order where status ='Ordered']);
        System.assertEquals(TestUtil.expectedCA, [select Chiffre_d_affaire__c from Account 
                                limit 1][0].Chiffre_d_affaire__c);
    }

/*    @isTest static void Negative_UpdateAccountCA_Test() {
        System.assertNotEquals();
    }
    static testMethod void Bulk_UpdateAccountCA_Test(){
        

    }
    */
}