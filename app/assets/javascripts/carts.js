// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

function applyCupon(cart_id) {
  var cupon = $('#cupon-field').val();
  $.get('/carts/apply_cupon.js', { cupon_code: cupon });
}
