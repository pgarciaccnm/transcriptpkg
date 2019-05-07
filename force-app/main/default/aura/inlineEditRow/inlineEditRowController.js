({
    
    doInit: function(component, event, helper) {
      // call the fetchPickListVal(component, field_API_Name, aura_attribute_name_for_store_options) -
      // method for get picklist values dynamic   
        helper.fetchPickListVal(component, 'Status', 'ratingPicklistOpts');
    },
    
    //Shipping Tracking Number
    inlineEditName : function(component,event,helper){   
        // show the name edit field popup 
        component.set("v.nameEditMode", true); 
        // after the 100 millisecond set focus to input field   
        setTimeout(function(){ 
            component.find("inputId").focus();
        }, 100);
    },
    
    inlineEditRating : function(component,event,helper){   
        // show the rating edit field popup 
        component.set("v.ratingEditMode", true); 
        // after set ratingEditMode true, set picklist options to picklist field 
        component.find("accRating").set("v.options" , component.get("v.ratingPicklistOpts"));
        // after the 100 millisecond set focus to input field   
        setTimeout(function(){ 
            component.find("accRating").focus();
        }, 100);
    }, 
    
    //Shipping Tracking Number
     onNameChange : function(component,event,helper){ 
        // if edit field value changed and field not equal to blank,
        // then show save and cancel button by set attribute to true

        if(event.getSource().get("v.value").trim() != ''){ 
            component.set("v.showSaveCancelBtn",true);
        }
    },   
    
    closeNameBox : function (component, event, helper) {
      // on focus out, close the input section by setting the 'nameEditMode' att. as false   
        component.set("v.nameEditMode", false); 
      // check if change/update Name field is blank, then add error class to column -
      // by setting the 'showErrorClass' att. as True , else remove error class by setting it False   
        if(event.getSource().get("v.value") && event.getSource().get("v.value").trim() == ''){
            component.set("v.showErrorClass",true);
        }else{
            component.set("v.showErrorClass",false);
        }
    }, 
    
	handleClick: function (component, event, helper) {
        var navEvt = $A.get("e.force:navigateToSObject");
alert(event.getSource().getElement().getAttribute('data-order-id'));
        navEvt.setParams({
            "recordId": event.getSource().getElement().getAttribute('data-order-id')
        });
       // navEvt.fire();
    }
   
})