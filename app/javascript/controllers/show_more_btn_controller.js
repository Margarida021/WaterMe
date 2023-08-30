import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="show-more-btn"
export default class extends Controller {
  static targets = ["show", "less"]

  connect() {
    console.log("Hello")
  }

  showmore() {
    this.showTarget.classList.toggle("d-none");
     if (this.lessTarget.innerText === "Show More") {
      this.lessTarget.innerText = "Show Less";
      console.log("if");
     } else {
      this.lessTarget.innerText = "Show More";
      console.log("else");
     }
  }

}
