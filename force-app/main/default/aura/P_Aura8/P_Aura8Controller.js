({
    handleUploadedImage: function(component, event, helper) {
        var imageSrc = event.getParam("imageSrc");
        component.set("v.imageSrc", imageSrc);
    }
})
