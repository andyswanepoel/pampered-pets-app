import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="pet-form"
export default class extends Controller {
  static targets = ["petTypeSelect", "petTypeAdditionalFormField"];

  initialize() {
    this.showAdditionalPetInfo();
  }

  showAdditionalPetInfo() {
    const petType = this.petTypeSelectTarget.value;
    const additionalFormFields = this.petTypeAdditionalFormFieldTargets;

    additionalFormFields.forEach(formField => {
      if (formField.dataset.pet === petType) {
        formField.hidden = false;
      } else {
        formField.hidden = true;
      }
    });
  }
}
