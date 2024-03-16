({
    saveData : function(component, event, helper) {
        var action = component.get("c.save");
        console.log(component.get("v.accountData"));
        console.log(component.get("v.contactData"));
        console.log(component.get("v.eventData"));
        action.setParams({
            accountData : component.get("v.accountData"),
            contactData : component.get("v.contactData"),
            eventData : component.get("v.eventData")
        });
        action.setCallback(this, function(response){
            var state = response.getState();
            var message = response.getReturnValue(); 
            component.set("v.message", message);
            if(message == 'Record successfully inserted'){
                        
                component.set("v.totalpages", 3);
                component.set("v.currentpage", 3);
                component.set("v.prcount", 33.33); 
                
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    "title": "Success!",
                    "message": "Contact has been created successfully.",
                    "type": "success"
                });
                toastEvent.fire(); 
                 
                component.set("v.accountData", { 'sobjectType': 'Account', 'Name': ''});
                component.set("v.contactData", { 'sobjectType': 'Contact', 'LastName': ''});
                component.set("v.eventData", { 'sobjectType': 'Event', 'Subject': '', 'StartDateTime': '', 'EndDateTime': '', 'Location': ''});
                 
                component.set("v.showAccount", true);
                component.set("v.showContact", false);
                component.set("v.showEvent", false);
                 
                component.set("v.showError", false);
                component.set("v.showData", false);
                 
                component.set("v.totalpages", 3);
                component.set("v.currentpage", 0);
                component.set("v.prcount", 33.33); 
                 
                document.getElementById("showErrorr").style.display = "none";
                document.getElementById("showMessage").style.display = "block";
            } else {
                document.getElementById("showMessage").style.display = "none";
                document.getElementById("showErrorr").style.display = "block";
            }    
        });  
        $A.enqueueAction(action);
    }
})
