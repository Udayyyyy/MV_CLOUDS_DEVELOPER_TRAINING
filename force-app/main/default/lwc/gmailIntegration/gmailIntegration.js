import { LightningElement, track } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import sendEmail from '@salesforce/apex/GmailIntegrationController.sendEmail';

export default class GmailIntegration extends LightningElement {
    @track button;
    @track To;
    @track Subject;
    @track Body;
    @track attachment;

    handleClick() {
        this.button = true;
        console.log(this.button);
    }

    handleClose() {
        this.button = null;
        console.log(this.button);
    }

    handleToChange(event) {
        this.To = event.target.value;
        console.log('to: ', this.To);
    }

    handleSubjectChange(event) {
        this.Subject = event.target.value;
        console.log('subject :', this.Subject);
    }

    handleBodyChange(event) {
        this.Body = event.target.value;
        console.log('body :', this.Body);
    }

    handleFileChange(event) {
        const file = event.target.files[0];
        if (file) {
            const reader = new FileReader();
            reader.onload = () => {
                this.attachment = {
                    attachmentName: file.name,
                    attachmentBase64: reader.result.split(',')[1]
                };
            };
            reader.readAsDataURL(file);
        }
    } 
    handleSendEmail() { 
    if (!this.To || !this.To.trim()) {
        this.showToast('Error', 'Please enter a valid email address', 'error');
        return;
    }
 
    if (!this.Subject || !this.Subject.trim()) {
        this.showToast('Error', 'Please enter a subject', 'error');
        return;
    }
 
    if (!this.Body || !this.Body.trim()) {
        this.showToast('Error', 'Please enter a body content', 'error');
        return;
    }
    console.log('Hi, I am at the final stage'); 
    let attachmentName = '';
    let attachmentBase64 = '';
    if (this.attachment) {
        attachmentName = this.attachment.attachmentName;
        attachmentBase64 = this.attachment.attachmentBase64;
    }
    console.log('attachmentName: ',attachmentName);
    console.log('attachmentBase64: ',attachmentBase64);
    sendEmail({ to: this.To, subject: this.Subject, body: this.Body, attachmentName: attachmentName, attachmentBase64: attachmentBase64 })
        .then(result => {
            console.log('Email sent successfully!');
            this.showToast('Success', 'Email sent successfully', 'success');
            this.clearFields();
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

    clearFields() {
        this.To = '';
        this.Subject = '';
        this.Body = '';
        this.attachment = null;
    }
}
