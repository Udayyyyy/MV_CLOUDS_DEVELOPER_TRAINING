({
    searchAccounts1: function(component, event, helper) {
        var searchText = component.find("search1").get("v.value"); 
        var action = component.get("c.searchAccounts");
        action.setParams({ searchkey: searchText });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set('v.accountsInSection1', response.getReturnValue());
                component.set('v.contactsInSection1', []);  
                component.set("v.count1", response.getReturnValue().length);
            } else if (state === "ERROR") {
                console.log("error");
            }
        });
        $A.enqueueAction(action);
    },
    
    searchAccounts2: function(component, event, helper) {
        var searchText = component.find("search2").get("v.value");
        var action = component.get("c.searchAccounts");
        action.setParams({ searchkey: searchText });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set('v.accountsInSection2', response.getReturnValue());
                component.set('v.contactsInSection2', []);  
                component.set("v.count2", response.getReturnValue().length);
            } else if (state === "ERROR") {
                console.log("error");
            }
        });
        $A.enqueueAction(action);
    },

    showContacts1: function(component, event, helper) {
        var accountId = event.getSource().get("v.value");
        component.set('v.selectedAccountId1', accountId);
        console.log('Selected Account ID for Section 1: ' + accountId);
        helper.fetchContacts(component, accountId, 'section1');
    },

    showContacts2: function(component, event, helper) {
        var accountId = event.getSource().get("v.value");
        component.set('v.selectedAccountId2', accountId); 
        console.log('Selected Account ID for Section 2: ' + accountId);
        helper.fetchContacts(component, accountId, 'section2');
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
                accountId = component.get("v.selectedAccountId1");
            } else if (targetSection === 'section2') {
                accountId = component.get("v.selectedAccountId2");
            } 
            var updateAction = component.get("c.updateContactAccountId");
            updateAction.setParams({
                contactId: contactId,
                accountId: accountId
            });

            updateAction.setCallback(this, function(response) {
                helper.fetchContacts(component, component.get('v.selectedAccountId1'), 'section1');
                helper.fetchContacts(component, component.get('v.selectedAccountId2'), 'section2');
                var state = response.getState();
                console.log(state);  
                if (state === "SUCCESS") {
                    component.set("v.contactsInSection1", response.getReturnValue().section1Contacts);
                    component.set("v.contactsInSection2", response.getReturnValue().section2Contacts);
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
        helper.callSearchFunctions(component);
    }
})
