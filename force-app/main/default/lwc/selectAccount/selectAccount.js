import { LightningElement, track, wire } from 'lwc';
import getAccountOptions from '@salesforce/apex/DropdownController.getAccountOptions';
import { MessageContext,publish } from 'lightning/messageService';
import pass from  '@salesforce/messageChannel/pass__c';

export default class SelectAccount extends LightningElement {
    @track selectedAccount = '';  
    @track accountOptions = [];  
    
    @wire (MessageContext) messageContext;

    connectedCallback() { 
        this.loadAccountOptions();
    }

    loadAccountOptions() {
        getAccountOptions()
            .then(result => { 
                this.accountOptions = result.map(acc => ({
                    label: acc.Name,
                    value: acc.Id
                }));
            })
            .catch(error => {
                console.error('Error fetching Account options:', error);
            });
    }
 
    handleAccountChange(event) {
        this.selectedAccount = event.detail.value;
    }
 
    handleSubmit() { 
        console.log('Selected Account:', this.selectedAccount);
        let payload={accid:this.selectedAccount};
         publish(this.messageContext,pass,payload)
    }
}
