//= require rails-ujs
//= require trix
document.addEventListener("turbo:load", function () {
  if (window.FB) {
    FB.XFBML.parse()
  }
})
