import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="onboarding"
export default class extends Controller {
  connect() {
    $('.slider').slick({
      arrows: false,
      dots: true,
      infinite: false,
      speed: 0,
      focusOnSelect: false,
      customPaging: function(slider, i) {
        return '<a><svg width="100%" height="100%" viewBox="0 0 16 16"><circle cx="8" cy="8" r="6.215"></circle></svg><span></span></a>';
      },
    }).on('beforeChange', function(event, slick, currentSlide, nextSlide) {
      $('.item').removeClass('from-right from-left ready');
      c = (currentSlide < nextSlide) ? 'from-right' : 'from-left';
      $('.item').eq(nextSlide).addClass(c);
    }).on('afterChange', function(event, slick, currentSlide) {
      $('.item').eq(currentSlide).addClass('ready');
    });
  }

}
