({
    saveDetails: function(component, event, helper) {
         
        var imageUrl = component.find("imageUrlInput").get("v.value");
        var backgroundColor = component.find("backgroundColorInput").get("v.value");
        var description = component.find("descriptionInput").get("v.value");
        var fontSize = component.find("fontSizeInput").get("v.value");
        var fontColor = component.find("fontColorInput").get("v.value");
         
        component.set("v.imageUrl", imageUrl);
        component.set("v.backgroundColor", backgroundColor);
        component.set("v.description", description);
        component.set("v.fontSize", fontSize);
        component.set("v.fontColor", fontColor);
         
        component.set("v.showInputs", false);
    }
})
