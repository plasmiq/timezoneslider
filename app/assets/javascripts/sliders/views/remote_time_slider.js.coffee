@Sliders.RemoteTimeSliderView = Sliders.CurrentTimeView.extend({
  template: SC.Handlebars.compile("{{hours}}<br/>{{minutes}}")
  classNames: ['remoteTimeSlider']
  
  leftBinding: "Sliders.RemoteTimeController.left"
  attributeBindings: ['style']
    
  style: (->
    left = 50 - 19/2 + Sliders.RemoteTimeController.get("left")
    "left: " + left + "px"
  ).property("left")
  
  phase: (->
    return this.get("left");
  ).property("left")
})

