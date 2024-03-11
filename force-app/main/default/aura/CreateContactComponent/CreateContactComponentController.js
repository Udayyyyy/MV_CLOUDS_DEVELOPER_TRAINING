({
    createContact : function(component, event, helper) {
        var fname = component.find("Fname").get("v.value"); 
        var lname = component.find("Lname").get("v.value"); 
        var phone = component.find("Phone").get("v.value"); 
        var email = component.find("Email").get("v.value"); 
		var action = component.get("c.insertcon");
        
        action.setParams({"fname": fname, "lname": lname, "phone": phone, "email": email });
		
        
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            "title": "Success!",
            "message": "Contact has been created successfully.",
            "type": "success"
    });
        toastEvent.fire(); 
            } else {
                alert("Error: " + response.getError());
            }
        });

        $A.enqueueAction(action);   
    }
 
})