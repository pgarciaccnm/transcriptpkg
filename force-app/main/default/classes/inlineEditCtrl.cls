public with sharing class inlineEditCtrl {



    @AuraEnabled
    public static List<Order> getOrders(Id caseId){
        
        return [select id, OrderNumber, Status, TotalAmount, Shipping_Track_Number__c,  (select id, OrderItemNumber, Product2Id, Product2.name, Product2.family from OrderItems)  orderProductItems from order where Case_Id__c =: caseId];        
        

    }    
    
    @AuraEnabled
    public static List<OrderConfirmation> getOrderConfirmations(Id caseId){
        
        System.debug('aaa'+caseId);
        List<Order> orders = [select id, OrderNumber, Status, TotalAmount, Shipping_Track_Number__c,  (select id, OrderItemNumber, Product2Id, Product2.name, Product2.family from OrderItems)  orderProductItems from order where Case_Id__c =: caseId];        


        List<OrderConfirmation> confirmationOrders = new List<OrderConfirmation>();
        
        for(Order oo : orders){
            
            OrderConfirmation oConfirmation = new OrderConfirmation();
            
           // oConfirmation.contactName = co.Name;
            oConfirmation.Id = oo.Id;
            
            oConfirmation.orderNumber = oo.OrderNumber;
     
            for(OrderItem oi : oo.OrderItems){
                
                if(oi.Product2.Family == 'Shipping Method'){
                    
                    oConfirmation.shippingMethod = oi.Product2.Name;
                }
                if(oi.Product2.Family == 'Transcript Type'){
                    
                    oConfirmation.ProductName = oi.Product2.Name;
                }

            }
 
            
            if(oo.Shipping_Track_Number__c != null && oo.Shipping_Track_Number__c.length() > 0 ){
                
                oConfirmation.trackingNumber 	= oo.Shipping_Track_Number__c;
                oConfirmation.hasTrackingNumber = true;
            }
            
           
            confirmationOrders.add(oConfirmation);
        }        

        System.debug('aaaa'+confirmationOrders);
        return confirmationOrders;
    }
    //method for fetch orders
    @AuraEnabled
    public static List<Order> fetchOrder(Id caseId){

       return (List<Order>) [Select id, case_id__c, ordernumber, status, Shipping_Track_Number__c, Shipping_Institution__c, Shipping_Attention__c, TotalAmount, ShippingStreet, ShippingCity, ShippingState, ShippingPostalCode, ShippingCountry, (select id, OrderItemNumber, Product2Id, Product2.name, Product2.family from OrderItems)  orderProductItems from Order where case_id__c = :caseId];
         
    }
    
    @AuraEnabled
    public static List< Order> saveOrder(List<Order> lstOrders) {

        if (!Schema.sObjectType.Order.fields.Shipping_Track_Number__c.isUpdateable()){
      		return lstOrders;
    	}
        update lstOrders;
        
        Set<Id> setCaseId = new Set<Id>();
        
        for(Order oo : lstOrders){
            
            setCaseId.add(oo.Case_Id__c);
            
        }
        

        return [Select id, case_id__c, ordernumber, status, Shipping_Track_Number__c, Shipping_Institution__c, Shipping_Attention__c, TotalAmount, ShippingStreet, ShippingCity, ShippingState, ShippingPostalCode, ShippingCountry, (select id, OrderItemNumber, Product2Id, Product2.name, Product2.family from OrderItems)  orderProductItems from Order where case_id__c IN : setCaseId];
        
    }
    

  // method for fetch picklist values dynamic  
    @AuraEnabled
    public static List < String > getselectOptions(sObject objObject, string fld) {
        system.debug('objObject --->' + objObject);
        system.debug('fld --->' + fld);
        List < String > allOpts = new list < String > ();
        // Get the object type of the SObject.
        Schema.sObjectType objType = objObject.getSObjectType();
        
        // Describe the SObject using its object type.
        Schema.DescribeSObjectResult objDescribe = objType.getDescribe();
        
        // Get a map of fields for the SObject
        map < String, Schema.SObjectField > fieldMap = objDescribe.fields.getMap();
        
        // Get the list of picklist values for this field.
        list < Schema.PicklistEntry > values =
            fieldMap.get(fld).getDescribe().getPickListValues();
        
        // Add these values to the selectoption list.
        for (Schema.PicklistEntry a: values) {
            allOpts.add(a.getValue());
        }
        system.debug('allOpts ---->' + allOpts);
        allOpts.sort();
        return allOpts;
    }
    
     public class OrderConfirmation{
        @AuraEnabled

        public String contactName {get;set;}
        @AuraEnabled

        public String contactEmail {get;set;}
        @AuraEnabled

        public String orderNumber {get;set;}
        @AuraEnabled

        public String shippingMethod {get; set;}
        @AuraEnabled

        public String productName {get;set;}
        @AuraEnabled

        public boolean hasTrackingNumber {get; set;}
        @AuraEnabled

        public String trackingNumber {get;set;}
         @AuraEnabled

         public String institutionName {get;set;}
         @AuraEnabled

         public String attentionName {get;set;}
         @AuraEnabled

         public String status {get;set;}
         @AuraEnabled

         public String totalAmount {get;set;}
        @AuraEnabled

         public String Id {get;set;}
        
    }
}