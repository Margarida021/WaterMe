import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["options"];
  static currentActiveCard = null;

  toggle() {
    if (Controller.currentActiveCard && Controller.currentActiveCard !== this) {
      Controller.currentActiveCard.hideLinks();
    }

    this.optionsTarget.classList.toggle("d-none");
    Controller.currentActiveCard = this;
  }

  hideLinks() {
    this.optionsTarget.classList.add("d-none");
  }

  disconnect() {
    if (Controller.currentActiveCard === this) {
      Controller.currentActiveCard = null;
    }
  }
}
