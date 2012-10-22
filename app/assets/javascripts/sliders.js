//= require_tree ./sliders/lib
//= require ./store
//= require_tree ./sliders/models
//= require_tree ./sliders/controllers
//= require_tree ./sliders/views
//= require_tree ./sliders/templates
//= require_self
//Sliders.initialize();


$(function() {
  var current_timezone = (new Date()).getTimezoneOffset() * (-60)
  Sliders.TimeController.startTicking();
  Sliders.SlidersController.createSlider("ME","current location",current_timezone);
})
