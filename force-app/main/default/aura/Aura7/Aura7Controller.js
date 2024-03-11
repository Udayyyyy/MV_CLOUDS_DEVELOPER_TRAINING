({
    init : function(component, event, helper) {
        var action = component.get("c.getAccountsWithRelatedInfo");
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                
                component.set("v.accountWrappers", response.getReturnValue());
            }
        });
        $A.enqueueAction(action); 
    }
})
