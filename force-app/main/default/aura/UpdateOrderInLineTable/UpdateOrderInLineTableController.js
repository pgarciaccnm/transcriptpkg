({
    startRecords :function(component, event, helper){
        var action = component.get("c.getOrders");
        action.setParams({ caseId : component.get("v.recordId") });

        action.setCallback(this, function(response) {
              
        var state = response.getState();
              if (state === "SUCCESS") {
                  var storeResponse = response.getReturnValue();
                  
  // debugging
        console.log('>>> Log 1.0: ' + JSON.stringify(response.getReturnValue()));
        console.log('>>> Log 1.1: ' + response.getReturnValue());
        console.log('>>> Log 1.2: ' + JSON.stringify(storeResponse));
        console.log('>>> Log 1.3: ' + storeResponse);
               // set AccountList list with return value from server.
               component.set("v.OrderList", storeResponse);
               component.set("v.OrderListSize", storeResponse.length)
            } 
            else{
            	alert(response.getState());
            }
        });
        $A.enqueueAction(action);        
    },
        
    initRecords: function(component, event, helper) {
      // call the apex class method and fetch account list  
         var action = component.get("c.fetchOrder");
        	action.setParams({ caseId : component.get("v.recordId") });

             action.setCallback(this, function(response) {
              var state = response.getState();
              if (state === "SUCCESS") {
                  var storeResponse = response.getReturnValue();
                  console.log(JSON.stringify(storeResponse));
               // set AccountList list with return value from server.
                  component.set("v.OrderList", storeResponse);
                  component.set("v.OrderListSize", storeResponse.length)
            } 
            else{
            	alert(response.getState());
            }
        });
        $A.enqueueAction(action);
    },
    
    Save: function(component, event, helper) {
      // Check required fields(Name) first in helper method which is return true/false
        if (helper.requiredValidation(component, event)){
              // call the saveAccount apex method for update inline edit fields update 
               var action = component.get("c.saveOrder");
                  action.setParams({
                    'lstOrders': component.get("v.OrderList")
                  });
            action.setCallback(this, function(response) {
                var state = response.getState();
                if (state === "SUCCESS") {
                    
              console.log('>>> Log 1.4: ' + component.get("v.OrderList"));      
                    var storeResponse = response.getReturnValue();
                    // set AccountList list with return value from server.
                    component.set("v.OrderList", storeResponse);
                    // Hide the save and cancel buttons by setting the 'showSaveCancelBtn' false 
                    component.set("v.showSaveCancelBtn",false);
                    alert('Updated...');
                }
            });
            $A.enqueueAction(action);
        } 
    },
    
    cancel : function(component,event,helper){
        
       // on cancel refresh the view (This event is handled by the one.app container. It’s supported in Lightning Experience, the Salesforce app, and Lightning communities. ) 
       $A.get('e.force:refreshView').fire(); 

    }
    
})