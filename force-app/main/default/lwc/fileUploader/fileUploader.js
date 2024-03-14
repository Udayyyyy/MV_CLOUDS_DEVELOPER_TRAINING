import { LightningElement, api, track } from 'lwc';
import uploadFile from '@salesforce/apex/FileUploaderController.uploadFile';

const ITEMS_PER_PAGE = 3;

export default class FileUploader extends LightningElement {
    @api recordId;
    @track uploadedFiles = [];
    @track displayedFiles = [];
    @track currentPage = 1;

    connectedCallback() { 
        this.uploadedFiles = [];
        this.displayedFiles = [];
    }

    get totalPages() {
        return Math.ceil(this.uploadedFiles.length / ITEMS_PER_PAGE);
    }

    fileChange(event) {
        const files = event.target.files;
        for (let i = 0; i < files.length; i++) {
            const file = files[i];
            const reader = new FileReader();
            reader.onload = () => {
                const base64 = reader.result.split(',')[1];
                this.uploadFile({ base64: base64, filename: file.name, recordId: this.recordId });
            };
            reader.readAsDataURL(file);
        } 
    }

    uploadFile(fileData) {
        uploadFile({ base64: fileData.base64, filename: fileData.filename, recordId: fileData.recordId })
            .then(result => {
                console.log(`Uploaded ${fileData.filename} Successfully!!`);
                this.uploadedFiles.push(fileData.filename);
                this.updateDisplayedFiles();  
            })
            .catch(error => {
                console.error(`Error uploading ${fileData.filename}: ${error}`);
            });
    }

    updateDisplayedFiles() {
        const start = (this.currentPage - 1) * ITEMS_PER_PAGE;
        const end = start + ITEMS_PER_PAGE;
        console.log(start, end);
        this.displayedFiles = this.uploadedFiles.slice(start, end);
        console.log(this.uploadedFiles.slice(start, end));
        console.log(this.displayedFiles);
        return this.displayedFiles;
    }

    previousPage() {
        if (this.currentPage > 1) {
            this.currentPage--;
            this.updateDisplayedFiles();
        }
    }

    nextPage() {
        if (this.currentPage < this.totalPages) {
            this.currentPage++;
            this.updateDisplayedFiles();
        }
    }
}
