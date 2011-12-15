@Sliders.CurrentTimeSliderView = Sliders.CurrentTimeView.extend
  classNames: ['currentTimeSlider']
  
  template: SC.Handlebars.compile("{{hour}}<br/>{{minutes}}")
  
  offset: 0
  
  calculateOffset: (->
    @set( "offset", @get("offset") + 1 )
  ).observes("timer")
  
  startPosition: (->
    margin_left = 50
    slider_width = 19
    margin_left - slider_width/2  
  ).property()

  minutesTodayBinding: "Sliders.LocalTimeController.minutesToday"

  style: (->
    time = 30 + @get("minutesToday")
    panel_width = 790
    minutes_per_day = 60 * 24
    pos = time * panel_width / minutes_per_day
    "left: " + (@get("startPosition") + pos) + "px"
  ).property("offset")
  
  attributeBindings: ['style']
