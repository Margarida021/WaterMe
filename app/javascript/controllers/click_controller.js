import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="click"
export default class extends Controller {

  connect() {
    // console.log("Hello")
    let path = document.location.pathname
    if (path == '/plants')
    {
      let search = document.getElementById("search");
      if (search) {
        document.querySelector(".active").classList.remove("active")
        search.classList.add("active");
      }
    } else if (path == '/divisions')
    {
      let user = document.getElementById("user");
      if (user) {
        document.querySelector(".active").classList.remove("active")
        user.classList.add("active");
      }
     } else if (path == '/home')
     {
       let home = document.getElementById("home");
       if (home) {
         document.querySelector(".active").classList.remove("active")
         home.classList.add("active");
       }
      } else {
      let menu = document.getElementById("menu");
      if (menu) {
        document.querySelector(".active").classList.remove("active")
        menu.classList.add("active");
      }
    }
  }

  onboarding() {
    // Pegar ultimo slide do carrosel
    // Adicionar evento no botão next
    // mudar o botão para start ou para disable




    // Pegar primeiro slide do carrosel
    // Adicionar evento no botão back
    // mudar o botão para disable
  }
}
