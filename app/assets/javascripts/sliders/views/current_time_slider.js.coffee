@Sliders.CurrentTimeSliderView = Sliders.CurrentTimeView.extend({
  classNames: ['currentTimeSlider']
  
  template: SC.Handlebars.compile("{{hours}}<br/>{{minutes}}<br/>{{seconds}}")
  
  left: (->
    this.$().animate("left","+1px");
  ).observes("timer")
  
  style: (->
    "left: 200px"
  ).property()
  
  attributeBindings: ['style']
})
