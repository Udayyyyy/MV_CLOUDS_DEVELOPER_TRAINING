({
   
    nextTab : function(component, event, helper) {
        component.set("v.setMessage", '');           
        var showAccount = component.get("v.showAccount");
        var showContact = component.get("v.showContact");
        var showEvent = component.get("v.showEvent");
         
        
        
        if(showAccount == true){
            var accountName = component.find("Name").get("v.value");

            console.log('accountName:::'+accountName);
            if(accountName =='' || accountName == null){
                component.set("v.setMessage",'error');           
            }
            if(component.get("v.setMessage")=='error')
            { 
                component.set("v.showContact",false);
                component.set("v.showEvent", false);
                component.set("v.showError", true);
                
                
            }
            else
            { 
                component.set("v.showAccount", false);
                component.set("v.showContact", true);
                component.set("v.showEvent", false); 
                component.set("v.showError", false);
                component.set("v.totalpages", 3);
                component.set("v.currentpage", 1);
                component.set("v.prcount", 33.33); 
                
            }
        }    
        if(showContact == true){
            var lastName = component.find("LastName").get("v.value");
            console.log('lastName:::'+lastName);
            var currentStep = component.get("v.currentStep");
            component.set("v.currentStep", currentStep + 1);
            if(lastName =='' || lastName == null){
                component.set("v.setMessage",'error');           
            }
            if(component.get("v.setMessage")=='error')
            { 
                component.set("v.showAccount", false);
                component.set("v.showEvent", false);
                component.set("v.showError", true); 
            }
            else
            { 
                component.set("v.showAccount", false);
                component.set("v.showContact", false);
                component.set("v.showEvent", true);
                component.set("v.showError", false); 
                        
                component.set("v.totalpages", 3);
                component.set("v.currentpage", 2);
                component.set("v.prcount", 33.33); 
            }
        }   
        
        if(showEvent == true){ 

    
            var currentStep = component.get("v.currentStep");
            component.set("v.currentStep", currentStep + 1);
            var eventName = component.find("EventName").get("v.value");
            console.log('eventName:::'+eventName);
            var eventDate = component.find("eventDate").get("v.value");
            console.log('eventDate:::'+eventDate);
            if((eventName =='' || eventName == null) || (eventDate =='' || eventDate == null)){
                component.set("v.setMessage",'error');           
            }
            if(component.get("v.setMessage")=='error')
            { 
                component.set("v.showAccount", false);
                component.set("v.showContact", false);
                component.set("v.showError", true); 
                
            }
            else
            { 
                component.set("v.showEvent", false);
                component.set("v.showContact", false);
                component.set("v.showAccount", false)
                component.set("v.showError", false); 
            }
        }   
        
    },
    prevTab : function(component, event, helper) {
        var showAccount = component.get("v.showAccount");
        var showContact = component.get("v.showContact");
        var showEvent = component.get("v.showEvent"); 
        
        
        if(showContact == true){
            component.set("v.showAccount", true);
            component.set("v.showContact", false);
            component.set("v.showEvent", false);
            component.set("v.showError", false); 
        }    
        if(showEvent == true){
            component.set("v.showAccount", false);
            component.set("v.showContact", true);
            component.set("v.showEvent", false);
            component.set("v.showError", false); 
        } 
 
    },
    
    saveRecord : function(component, event, helper) {
        
        helper.saveData(component, event, helper);               
    }
})
