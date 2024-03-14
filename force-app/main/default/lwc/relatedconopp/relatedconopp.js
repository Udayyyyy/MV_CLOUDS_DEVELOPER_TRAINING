import { subscribe, unsubscribe, MessageContext } from 'lightning/messageService';
import { LightningElement, wire, track } from 'lwc';
import pass from '@salesforce/messageChannel/pass__c';
import getRelatedContacts from '@salesforce/apex/RelatedRecordsController.getRelatedContacts';
import getRelatedOpportunities from '@salesforce/apex/RelatedRecordsController.getRelatedOpportunities';


export default class Relatedconopp extends LightningElement {
    @track accountId = '';
    @track relatedContacts = [];
    @track relatedOpportunities = [];
    subscription = null;

    @wire(MessageContext)
    messageContext;

    connectedCallback() {
        this.handleSubscribe();
    }

    disconnectedCallback() {
        this.handleUnsubscribe();
    }

    handleSubscribe() {
        if (!this.subscription) {
            this.subscription = subscribe(this.messageContext, pass, (message) => {
                this.accountId = message.accid;
                this.loadRelatedRecords();
            });
        }
    }

    handleUnsubscribe() {
        unsubscribe(this.subscription);
        this.subscription = null;
    }

    loadRelatedRecords() {
        getRelatedContacts({ accountId: this.accountId })
            .then(result => {
                this.relatedContacts = result;
                console.log(JSON.stringify(result));
            })
            .catch(error => {
                console.error('Error loading related contacts:', error);
            });

        getRelatedOpportunities({ accountId: this.accountId })
            .then(result => {
                this.relatedOpportunities = result;
                console.log('Related Opps: ' + JSON.stringify(result));
            })
            .catch(error => {
                console.error('Error loading related opportunities:', error);
            });
    }
}
