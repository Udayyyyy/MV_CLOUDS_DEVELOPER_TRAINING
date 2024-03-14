import { LightningElement, track } from 'lwc';
import getUploadedFiles from '@salesforce/apex/FileUploaderController.getUploadedFiles';

const PAGE_SIZE = 5;

export default class LWC3 extends LightningElement {
    @track uploadedFiles = {};
    @track displayedFiles = [];
    @track currentPage = 1;
    @track pageSize = PAGE_SIZE;

    connectedCallback() {
        this.loadUploadedFiles();
    }

    loadUploadedFiles() {
        getUploadedFiles({ recordId: this.recordId })
            .then(result => {
                this.uploadedFiles = result;
                this.displayedFiles = this.uploadedFiles.data.slice(0, this.pageSize);
            })
            .catch(error => {
                console.error('Error fetching uploaded files', error);
            });
    }

    handleFileChange(event) {
        const file = event.target.files[0];
        // Implement file upload logic here and call loadUploadedFiles() after successful upload
    }

    handlePageChange(event) {
        this.currentPage = event.detail.page;
        const startIndex = (this.currentPage - 1) * this.pageSize;
        this.displayedFiles = this.uploadedFiles.data.slice(startIndex, startIndex + this.pageSize);
    }
}
