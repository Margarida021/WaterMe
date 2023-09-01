import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="plantphotoform"
export default class extends Controller {
  connect() {
    const childNodes = document.querySelectorAll('.lc');
    if (childNodes) {
    for (let i in childNodes) {
      childNodes[i].insertAdjacentHTML("afterbegin", `<img src="${}" style="width:80px; height:80px">`)
    }}
  }
}
