//= require_tree ./sliders/lib
//= require ./store
//= require_tree ./sliders/models
//= require_tree ./sliders/controllers
//= require_tree ./sliders/views
//= require_tree ./sliders/templates
//= require_self
//Sliders.initialize();

$(function() {
  if( Sliders.SlidersController.get("content").length == 0 ) {
  	var current_timezone = (new Date()).getTimezoneOffset() * (-60)
  	Sliders.SlidersController.createSlider("ME","current location",current_timezone);
  };

  // Make them tick on same time #need a fix
  Sliders.SlidersController.updateSliders(0);

  Sliders.TimeController.startTicking();
})
