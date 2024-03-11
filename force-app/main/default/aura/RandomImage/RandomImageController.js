({
    addRandomImage: function(component, event, helper) {
        var opportunityId = component.get("v.recordId");
        console.log("Opportunity ID:", opportunityId);
        
        var action = component.get("c.addRandomImg");
        action.setParams({ opportunityId: opportunityId });
        
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") { 
                console.log('SUCCESS');
            }  
        });
        $A.enqueueAction(action);
    }
})
