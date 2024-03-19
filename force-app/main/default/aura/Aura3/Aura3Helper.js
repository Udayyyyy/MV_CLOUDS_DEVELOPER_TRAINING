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
                 console.log("error");
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
                 console.log("error");
            }
        });
        $A.enqueueAction(action);
    },

    showContacts: function(component, event, helper) {
        var accountId = event.currentTarget.dataset.accountid;
        var section = event.currentTarget.closest('[data-section]').getAttribute('data-section');
        if (section === 'section1') {
            component.set('v.selectedAccountId1', accountId);
        } else if (section === 'section2') {
            component.set('v.selectedAccountId2', accountId);
        }
        helper.fetchContacts(component, accountId, section);
    },

    fetchContacts: function(component, accountId, section) {
        var action = component.get("c.getContactsByAccountId");
        action.setParams({ accountId: accountId });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                if (section === 'section1') {
                    component.set('v.contactsInSection1', response.getReturnValue());
                    component.set("v.count1", response.getReturnValue().length);
                } else if (section === 'section2') {
                    component.set('v.contactsInSection2', response.getReturnValue());
                    component.set("v.count2", response.getReturnValue().length);
                }
            } else if (state === "ERROR") {
                 console.log("error");
            }
        });
        $A.enqueueAction(action);
    },

    callSearchFunctions: function(component) {
        this.searchAccounts1(component);
        this.searchAccounts2(component);
    }
})
