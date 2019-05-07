({
	doInit: function(component, event, helper) {
        
        var getList = JSON.stringify(component.get('v.items')); 
        
        var getElementList = component.get('v.elementList');
  
        var getElementListArray = getElementList.split('|');
       
        var elementIndexed = 0;

       	for(var elment in getElementListArray){
            
            elementIndexed = elementIndexed + getList.indexOf(getElementListArray[elment]);

           console.log('1.11.1>>>'+elementIndexed);
            console.log('1.22.1>>>'+elment);
            console.log('1.33.1>>>'+getList);
        }



        if(elementIndexed > 0){
          component.set('v.condition',true);
        }else{
          component.set('v.condition',false);
        }
    }
})