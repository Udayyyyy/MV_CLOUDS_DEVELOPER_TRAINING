import { LightningElement, track } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import sendEmail from '@salesforce/apex/EmailController.sendEmail';
import getRelatedRecords from '@salesforce/apex/EmailController.getRelatedRecords';

export default class WizardComponent extends LightningElement {
    @track selectedObject;
    @track recordList;
    @track selectedRecords = [];
    @track emailBody;
    @track emailSubject;

    @track showSection1 = true;
    @track showSection2 = false;
    @track showSection3 = false;
    @track errorMessage;
    @track errorMessage2;
    connectedCallback(){
        
    this.emailSubject='LWC Wizard Email';
    }
    objectOptions = [
        { label: 'Lead', value: 'Lead' },
        { label: 'Account', value: 'Account' },
        { label: 'Contact', value: 'Contact' }
    ];
    
    handleObjectChange(event) {
        this.errorMessage='';
        this.selectedObject = event.detail.value;
        console.log(this.selectedObject);
        this.fetchRecordList();
    }

    // handleRecordChange(event) {
    //     this.selectedRecords = event.detail.value;
    //     console.log(this.selectedRecords);
    //     console.log(event.detail.value);
    // }
    handleRecordChange(event) {
        const checkboxValue = event.target.dataset.recordId
    if (event.target.checked) {
        this.selectedRecords.push(checkboxValue);
        console.log(this.selectedRecords);

    } else {
         this.selectedRecords = this.selectedRecords.filter(recordId => recordId !== checkboxValue);

    }
}

fetchRecordList() {
        if (this.selectedObject) {
            getRelatedRecords({ objectType: this.selectedObject })
                .then(result => {
                    console.log(result);
                    this.recordList = result;
                })
                .catch(error => {
                    console.error('Error fetching record list:', error);
                });
        }
    } 
    handleEmailBodyChange(event) {
        this.emailBody = event.detail.value;
    }

    handleNext() {
        
    console.log(this.emailSubject);
    console.log(this.emailBody);

        if (this.showSection1) {
             if (!this.selectedObject) {
        this.errorMessage = 'Please select an object.';
        return;
    }
 
    if (this.selectedRecords.length === 0) {
        this.errorMessage = 'Please select at least one record.';
        return;
    }
            this.showSection1 = false;
            this.showSection2 = true;
        } else if (this.showSection2) {
             if (!this.emailBody || this.emailBody.trim() === '') {
            this.errorMessage2 = 'Email body cannot be empty';
            return;
        }
            this.errorMessage2 = ''; 
            this.showSection2 = false;
            this.showSection3 = true;
        }
    }

    handlePrevious() {
        if (this.showSection2) {
            // Logic to go back to Section 1
            this.showSection2 = false;
            this.showSection1 = true;
        } else if (this.showSection3) {
            // Logic to go back to Section 2
            this.showSection3 = false;
            this.showSection2 = true;
        }
    }
    handleSendEmail() {
        sendEmail({ subject: this.emailSubject, body: this.emailBody, recordIds: this.selectedRecords, objectType: this.selectedObject })
            .then(result => { 
                console.log('Email sent successfully:', result);
                this.showToast('Success', 'Email sent successfully', 'success');
            })
            .catch(error => { 
                console.error('Error sending email:', error);
            });
    }
    showToast(title, message, variant) {
        const toastEvent = new ShowToastEvent({
            title: title,
            message: message,
            variant: variant,
        });
        this.dispatchEvent(toastEvent);
    }
}
