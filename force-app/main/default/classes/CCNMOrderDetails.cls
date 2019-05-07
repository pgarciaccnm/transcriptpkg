public class CCNMOrderDetails {
    
  	public Id accountId {get;set;}
    
    public Id contactId {get;set;}
    
    Public String caseNumber;
    
    List<Case> cases=new List<Case>();
    
    List<Id> caseIds=new List<Id>();
    
    public Decimal GranTotal {get;set;}
    
    public Account getAccount(){
        
        return [Select id, Name from Account where id =:accountId ];
    }
    
    /**
     * 
     * @return List<Case> the most recently case
     */
    public List<Case> getCase(){
        
        return new List<Case>([SELECT id, CaseNumber FROM Case WHERE Accountid =:accountId Order by createddate Limit 1]);
    }
    
    public Integer getCountCases(){
        
        return [SELECT count() FROM Case WHERE Accountid =:accountId];
    }
    
    public List<Case> getCases()
    {
        cases = [SELECT id,CaseNumber FROM Case WHERE Accountid =:accountId];
        
        for(Case c : cases){
        
            caseIds.add(c.id);
            
        }

        return cases;

    }
    
    public void getGranTotal(List<Order> orders){

        GranTotal = 0.0;

        for(Order ord : orders){
           
          GranTotal = GranTotal + ord.TotalAmount;
        }
    }
    
    public List<Order> getOrders(){

        List<Order> orders;
        
        orders = [select id, OrderNumber, Status, TotalAmount, (select id,OrderItemNumber, Product2Id, Product2.name, TotalPrice, Description from OrderItems), ShippingStreet, ShippingCity, ShippingPostalCode, ShippingState, ShippingCountry, Shipping_Institution__c, Shipping_Attention__c from order where Case_Id__c in: this.getCase()];

        this.getGranTotal(orders);
        

        return orders;
    }
}