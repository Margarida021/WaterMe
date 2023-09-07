import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["options", "background"];
  static values = {
    plantLightLevel: String,
    divisionLightDirection: String
  }
  static currentActiveCard = null;

  toggle() {
    if (Controller.currentActiveCard && Controller.currentActiveCard !== this) {
      Controller.currentActiveCard.hideLinks();
    }

    this.optionsTarget.classList.toggle("d-none");
    this.backgroundTarget.classList.toggle("card-selected-js")
    Controller.currentActiveCard = this;
  }

  hideLinks() {
    this.optionsTarget.classList.add("d-none")
    this.backgroundTarget.classList.remove("card-selected-js");
  }

  warning() {
    if (this.plantLightLevelValue !== this.divisionLightDirectionValue) {
      Swal.fire({
        icon: 'warning',
        title: 'Light Mismatch',
        text: `This plant needs to be in ${this.plantLightLevelValue}, but your division is ${this.divisionLightDirectionValue}`,
        confirmButtonColor: '#3085d6',
        confirmButtonText: 'OK'
      });
    };
  }

  missing () {
    Swal.fire({
      icon: 'warning',
      title: 'No Divisions',
      text: `Want to create a division?`,
      confirmButtonColor: '#81A682',
      confirmButtonText: 'Yes'
    });
  }

  disconnect() {
    if (Controller.currentActiveCard === this) {
      Controller.currentActiveCard = null;
    }
  }
}
