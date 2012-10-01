Sliders = Ember.Application.create();

$(function() {
  var current_timezone = (new Date()).getTimezoneOffset() * (-60)
  Sliders.TimeController.startTicking();
  Sliders.SlidersController.createSlider("ME","CURRENT LOCATION",current_timezone);
})