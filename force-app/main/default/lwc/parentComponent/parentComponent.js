import { LightningElement, track } from 'lwc';

export default class ParentComponent extends LightningElement {
     imageData;

    handleFileChange(event) {
        const file = event.target.files[0];
        const reader = new FileReader();
        reader.onload = () => {
            this.imageData = reader.result;
        };
        reader.readAsDataURL(file);
    }
}
