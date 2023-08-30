import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="add-nav"
export default class extends Controller {
  static targets = ["content"]

  connect() {
  }

  revealContent() {
    this.contentTarget.classList.toggle("d-none");
  }
}
