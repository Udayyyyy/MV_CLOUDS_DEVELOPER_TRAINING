({
    doInit: function(component, event, helper) {

        var pageSize = component.get("v.pageSize");
         var accountId = component.get("v.recordId");
         console.log('hi',component.get("v.recordId"));
        console.log(accountId);
        var action = component.get("c.getAccountContacts");
         action.setParams({
            "accountId": accountId
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (component.isValid() && state === "SUCCESS") {
                component.set('v.contactList', response.getReturnValue());
                component.set("v.totalSize", component.get("v.contactList").length);
                component.set("v.start", 0);
                component.set("v.end", pageSize - 1);
                var paginationList = [];
                for (var i = 0; i < pageSize; i++) {
                    paginationList.push(response.getReturnValue()[i]);
                }
                component.set('v.paginationList', paginationList);
            }
        });
        $A.enqueueAction(action);
    },

    searchKeyChange: function(component, event) {
        var searchKey = component.find("input1").get("v.value");
        var accountId = component.get("v.recordId");
        var action = component.get("c.getByName");
        action.setParams({
            "searchKey": searchKey,
            "accountId": accountId
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (component.isValid() && state === "SUCCESS") {
                component.set('v.contactList', response.getReturnValue());
                component.set("v.totalSize", component.get("v.contactList").length);
                 
                component.set("v.start", 0);
                component.set("v.end", component.get("v.pageSize") - 1);
 
                var paginationList = [];
                for (var i = 0; i < component.get("v.pageSize"); i++) {
                    if (response.getReturnValue()[i]) {
                        paginationList.push(response.getReturnValue()[i]);
                    }
                }
                component.set('v.paginationList', paginationList);
            }
        });
        $A.enqueueAction(action);
    },

    next: function(component, event, helper) {
        var conList = component.get("v.contactList");
        var end = component.get("v.end");
        var start = component.get("v.start");
        var pageSize = component.get("v.pageSize");
        var paginationList = [];
        for (var i = end + 1; i <= end + pageSize && i < conList.length; i++) {
            paginationList.push(conList[i]);
        }
        start = start + pageSize;
        end = end + pageSize;
        component.set("v.start", start);
        component.set("v.end", end);
        component.set('v.paginationList', paginationList);
    },

    previous: function(component, event, helper) {
        var conList = component.get("v.contactList");
        var end = component.get("v.end");
        var start = component.get("v.start");
        var pageSize = component.get("v.pageSize");
        var paginationList = [];
        for (var i = start - pageSize; i < start; i++) {
            paginationList.push(conList[i]);
        }
        start = start - pageSize;
        end = end - pageSize;
        component.set("v.start", start);
        component.set("v.end", end);
        component.set('v.paginationList', paginationList);
    }
})
