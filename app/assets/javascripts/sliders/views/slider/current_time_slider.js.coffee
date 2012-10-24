@Sliders.CurrentTimeSliderView = Ember.View.extend
  classNames: ['currentTimeSlider']
  minutesTodayBinding: "controller.localMinutes"
  template: Ember.Handlebars.compile("<div>{{view.clock.hour}}</div><div>{{view.clock.minutes}}</div>")
  controller: Sliders.TimeController
  attributeBindings: ['style']

  style: (->
    margin_left = 61
    slider_width = 19
    panel_width = 768
    minutes_per_day = 60 * 24
    time = @get("minutesToday")
    posistion = time * panel_width / minutes_per_day
    start_position = margin_left - slider_width / 2  
    from_left = start_position + posistion
    if time then display = "block" else display = "none"
    ["left: ", from_left, "px; display: ", display ].join("")
  ).property("minutesToday")