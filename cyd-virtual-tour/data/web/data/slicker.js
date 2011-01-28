$(document).ready(function() {
 // hides the slickbox as soon as the DOM is ready (a little sooner that page load)
  $('#slickbox').hide();
  $('#slick-toggle').click(function() {
    $('#slickbox').slideToggle(400);
    return false;
  });
});