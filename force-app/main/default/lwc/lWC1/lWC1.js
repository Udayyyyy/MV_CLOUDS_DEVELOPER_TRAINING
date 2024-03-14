import { LightningElement } from 'lwc';
import createContact from '@salesforce/apex/ContactController.createContact';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class LWC1 extends LightningElement {
    contactName='';
    mobileNumber='';

    handleNameChange(event) {
        this.contactName = event.target.value;
    }

    handleMobileChange(event) {
        this.mobileNumber = event.target.value;
    }

    oncreateContact() {
        

        createContact({ 'LastName': this.contactName,'MobilePhone': this.mobileNumber})
            .then(result => {
                this.showToast('Success', 'Contact created successfully', 'success');
                this.contactName = '';
                this.mobileNumber = '';
            })
            .catch(error => {
                this.showToast('Error', 'Error creating contact', 'error');
                console.error('Error creating contact', error);
            });
    } 

    showToast(title, message, variant) {
        const event = new ShowToastEvent({
            title: title,
            message: message,
            variant: variant
        });
        this.dispatchEvent(event);
    }
}
