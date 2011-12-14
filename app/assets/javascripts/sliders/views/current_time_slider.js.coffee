@Sliders.CurrentTimeSliderView = Sliders.CurrentTimeView.extend
  classNames: ['currentTimeSlider']
  
  template: SC.Handlebars.compile("{{hour}}<br/>{{minutes}}")
  
  left: (->
    this.$().animate("left","+1px");
  ).observes("timer")
  
  style: (->
    left = 50 - 19/2
    shift = Sliders.LocalTimeController.getHoursShift( @get("timezone") )
    time = ( @get("hours") * 60 )  + @get("minutes") + ( shift * 60 ) 
    pos = time * 790 / 1440
    left += pos
    "left: " + left + "px"
  ).property()
  
  attributeBindings: ['style']
