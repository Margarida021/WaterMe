import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="weather"
export default class extends Controller {

  static values = { apiKey: String }

  connect() {
    const url = `https://api.openweathermap.org/data/2.5/weather?lat=38.73&lon=-9.14&appid=${this.apiKeyValue}`;
    fetch(url)
    .then(response => response.json())
    .then((data) => {
      console.log(data.name);

      document.getElementById("degree").innerText = `${ parseInt(data.main.feels_like, 10) - 273}º`;

    });
};
  }
