import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="plantphotoform"
export default class extends Controller {
  connect() {
    
    var childNodes = document.querySelectorAll('.lc');
    if (childNodes) {
    for (var i in childNodes) {
      childNodes[i].insertAdjacentHTML("afterbegin", `<img src="${}" style="width:80px; height:80px">`)
    }}
  }
}
