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
            console.log("message>>>>>>>>" + JSON.stringify(message));
            component.set("v.message", message);
            if(message == 'Record successfully inserted'){
                document.getElementById("showErrorr").style.display = "none";
                document.getElementById("showMessage").style.display = "block";
            }else{
                document.getElementById("showMessage").style.display = "none";
                document.getElementById("showErrorr").style.display = "block";
            }    
        });  
        $A.enqueueAction(action);
    }
})
