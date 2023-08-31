import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["options", "background"];
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

  disconnect() {
    if (Controller.currentActiveCard === this) {
      Controller.currentActiveCard = null;
    }
  }
}
