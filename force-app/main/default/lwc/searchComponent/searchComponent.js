import { LightningElement, track, wire } from 'lwc';
import searchAll from '@salesforce/apex/SearchController.searchAll';

export default class SearchComponent extends LightningElement {
    @track searchTerm = '';
    @track searchResults = [];
    @track selectedObjects = [];  
    objectOptions = [
        { label: 'Account', value: 'Account' },
        { label: 'Contact', value: 'Contact' },
        { label: 'Opportunity', value: 'Opportunity' }
    ];
    handleObjectChange(event) {
        this.selectedObjects = event.detail.value;
        console.log('Selected Objects:', this.selectedObjects); 
    }
    handleSearchTermChange(event) {
        this.searchTerm = event.target.value;
        console.log(this.searchTerm);
    }

    search() {
        console.log('I am in search.');
        searchAll({ searchTerm: this.searchTerm, selectedObjects: this.selectedObjects  })
            .then(result => {
                this.searchResults = result;
                console.log('i am here');
                console.log(this.searchResults);
                console.log(JSON.stringify(this.searchResults));
            })
            .catch(error => {
                console.error(error);
            });
    }
}
