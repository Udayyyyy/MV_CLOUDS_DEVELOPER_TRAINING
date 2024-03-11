({
    searchAccounts1: function(component, event, helper) {
        var searchText = component.find("search1").get("v.value"); 
        var action = component.get("c.searchaccountcontact");
        action.setParams({ searchkey: searchText });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set('v.contactsInSection1', response.getReturnValue());
                component.set("v.count1", response.getReturnValue().length);
            } else if (state === "ERROR") {
                // Handle errors
            }
        });
        $A.enqueueAction(action);
    },
    
    searchAccounts2: function(component, event, helper) {
        var searchText = component.find("search2").get("v.value");
        var action = component.get("c.searchaccountcontact");
        action.setParams({ searchkey: searchText });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set('v.contactsInSection2', response.getReturnValue());
                component.set("v.count2", response.getReturnValue().length);
            } else if (state === "ERROR") {
                // Handle errors
            }
        });
        $A.enqueueAction(action);
    },

    dragStart: function(component, event, helper) {
    var contactId = event.target.dataset.contactid;
    var section = event.target.closest('[data-section]').getAttribute('data-section');
    event.dataTransfer.setData("contactId", contactId);
    event.dataTransfer.setData("section", section);
    },

    drop: function(component, event, helper) {

        event.preventDefault();
        var contactId = event.dataTransfer.getData("contactId"); 
        var targetSection = event.target.closest('[data-section]').getAttribute('data-section');
        var sourceSection = event.dataTransfer.getData("section");
        if (contactId && targetSection && sourceSection && targetSection !== sourceSection) {
            var accountId = '';   
            if (targetSection === 'section1') {
              
                accountId = component.get("v.contactsInSection1")[0].AccountId; 
                
            } else if (targetSection === 'section2') {
                accountId = component.get("v.contactsInSection2")[0].AccountId;  
                 
            } 
            var updateAction = component.get("c.updateContactAccountId");
            updateAction.setParams({
                contactId: contactId,
                accountId: accountId
            });
            

            updateAction.setCallback(this, function(response) {
                var state = response.getState();
                if (state === "SUCCESS") {
                    component.set("v.contactsInSection1", response.getReturnValue().section1Contacts);
                    component.set("v.contactsInSection2", response.getReturnValue().section2Contacts);
                    this.searchAccounts1(component, event, helper);
                    this.searchAccounts2(component, event, helper);

                    alert("success");
                } else if (state === "ERROR") {
                    console.log('error');
                    alert('error');
                 }
            });
            $A.enqueueAction(updateAction);
        }
    },

    dragover: function(component, event, helper) {
        event.preventDefault(); 
    }
})
