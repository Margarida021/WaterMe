import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="onboarding"
export default class extends Controller {
  static targets = ["middleSlide", "btnStart", "btnNext", "btnBack"]
  connect() {
    this.btnBackTarget.disabled = true;
  }

  fire() {
    this.btnBackTarget.disabled = false;

    if (this.middleSlideTarget.classList.contains('active')) {
      this.btnNextTarget.classList.add('d-none');
      this.btnStartTarget.classList.remove('d-none');
    }
  }
}
