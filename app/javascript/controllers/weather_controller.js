import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="weather"
export default class extends Controller {
  connect() {
    const url = `https://api.openweathermap.org/data/2.5/weather?lat=38.73&lon=-9.14&appid=ab9b11880ba004ac5b45768d05fa918b`;
    fetch(url)
    .then(response => response.json())
    .then((data) => {
      console.log(data);

      document.getElementById("degree").innerText = `${ parseInt(data.main.feels_like, 10) - 273}º`;
      // TODO: Insert the weather info in the DOM (description, date, temperature...)
    });
};
  }
