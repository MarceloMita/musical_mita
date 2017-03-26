// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

function applyCupon() {
  var cupon = $('#cupon-field').val();
  $.get('/carts/apply_cupon');
}
