import { LightningElement, track } from 'lwc';
import sendEmail from '@salesforce/apex/GmailIntegrationController.sendEmail'
export default class GmailIntegration extends LightningElement {
    @track button;
    @track To;
    @track Subject;
    @track Body;
 

    handleClick(){
        this.button='true';
        console.log(this.button);
    }
    handleClose(){
        this.button=null;
        console.log(this.button);
    }
    handleToChange(event){
        this.To=event.target.value;
        console.log('to: ',this.To)
    }
    handleSubjectChange(event){
        this.Subject = event.target.value;
        console.log('subject :',this.Subject);        
    }
    handleBodyChange(event){
        this.Body =  event.target.value;
        console.log('body :',this.Body);        
    }
        handleSendEmail() {
         console.log('Hi I am At final stage');
         const toList = this.To.split(',').map(email => email.trim());

    sendEmail({ toList: toList, subject: this.Subject, body: this.Body })
        .then(() => { 
            this.showToast('Success', 'Email sent successfully', 'success');
            console.log('Email sent successfully!');
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