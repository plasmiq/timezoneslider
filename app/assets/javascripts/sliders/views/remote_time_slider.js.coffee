@Sliders.RemoteTimeSliderView = Sliders.CurrentTimeView.extend({
  template: SC.Handlebars.compile("{{left}}<br/>{{hours}}<br/>{{minutes}}<br/>{{seconds}}")
  classNames: ['remoteTimeSlider']
  
  leftBinding: "Sliders.RemoteTimeController.left"
  attributeBindings: ['style']
    
  style: (->
    "left: " + Sliders.RemoteTimeController.get("left") + "px";
  ).property("left")
  
  phase: (->
    return this.get("left");
  ).property("left")
})

