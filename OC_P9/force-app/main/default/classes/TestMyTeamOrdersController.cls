@isTest
public with sharing class TestMyTeamOrdersController {
    @TestSetup
    static void makeData() {
        TestDataFactory.LoadData(100, 'Ordered');
    }

    @isTest
    public static void testDisplay() {
        PageReference pageRef = Page.OrderCommercial;
        Test.setCurrentPage(pageRef);
    }
}
