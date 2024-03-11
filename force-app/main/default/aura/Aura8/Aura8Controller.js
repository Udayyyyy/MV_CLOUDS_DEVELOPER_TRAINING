({
    handleFileChange: function(component, event, helper) {
        var fileInput = component.find("fileInput").getElement();
        var file = fileInput.files[0];
        
        if (file) {
            var reader = new FileReader();
            reader.onload = function(e) {
                var imageSrc = e.target.result;
                var uploadImageEvent = component.getEvent("Event_Aura8");
                
                uploadImageEvent.setParams({ "imageSrc": imageSrc });
                uploadImageEvent.fire();
                
            }
            reader.readAsDataURL(file);
             
        }
    }
})
