@Sliders.CurrentTimeSliderView = Sliders.CurrentTimeView.extend
  template: Ember.Handlebars.compile("{{clock.hour}}<br/>{{clock.minutes}}")
  classNames: ['currentTimeSlider']
  minutesTodayBinding: "Sliders.TimeController.localMinutes"
  attributeBindings: ['style']

  startPosition: (->
    margin_left = 50
    slider_width = 19
    margin_left - slider_width/2  
  ).property()

  style: (->
    time = 30 + @get("minutesToday")
    panel_width = 790
    minutes_per_day = 60 * 24
    pos = time * panel_width / minutes_per_day
    "left: " + (@get("startPosition") + pos  ) + "px"
  ).property("minutesToday")