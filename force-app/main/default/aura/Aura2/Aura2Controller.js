    ({
        doInit: function(component, event, helper) {
            var pageSize = component.get("v.pageSize");
            var action = component.get("c.getAccountContacts");
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
            console.log(searchKey);
            var action = component.get("c.getByName");
            var keysize = component.get("v.totalSize");
            action.setParams({
                "searchKey": searchKey
            });
            action.setCallback(this, function(response) {
                var state = response.getState();
                if (component.isValid() && state === "SUCCESS") {
                    component.set('v.contactList', response.getReturnValue());
                    component.set("v.totalSize", component.get("v.contactList").length);
                    var paginationList = [];
                    for (var i = 0; i < keysize; i++) {
                        paginationList.push(response.getReturnValue()[i]);
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
            var counter = 0;
            for (var i = end + 1; i < end + pageSize + 1; i++) {
                if (conList.length > end) {
                    paginationList.push(conList[i]);
                    counter++;
                }
            }
            start = start + counter;
            end = end + counter;
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
            var counter = 0;
            for (var i = start - pageSize; i < start; i++) {
                if (i > -1) {
                    paginationList.push(conList[i]);
                    counter++;
                } else {
                    start++;
                }
            }
            start = start - counter;
            end = end - counter;
            component.set("v.start", start);
            component.set("v.end", end);
            component.set('v.paginationList', paginationList);
        }
    })
