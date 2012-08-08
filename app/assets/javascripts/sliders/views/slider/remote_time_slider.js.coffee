@Sliders.RemoteTimeSliderView = Sliders.CurrentTimeView.extend
  template: Ember.Handlebars.compile("{{hour}}<br/>{{minutes}}")
  classNames: ['remoteTimeSlider']
 
  attributeBindings: ['style']
   
  startPosition: (->
    margin_left = 50
    slider_width = 19
    margin_left - slider_width/2  
  ).property()

  minutesTodayBinding: "Sliders.TimeController.remoteMinutes"

  phase: (->
    @get("minutesToday")
  ).property("minutesToday")

  style: (->
    time = @get("minutesToday")
    panel_width = 790
    minutes_per_day = 60 * 24
    pos = time * panel_width / minutes_per_day
    if time
      "left: " + (@get("startPosition") + pos) + "px"
    else
     "display: none"
  ).property("minutesToday")
  
  moved: false

  mouseUp: ->
    Sliders.TimeController.stopMovingRemoteTime()
  
  mouseDown: ->
    Sliders.TimeController.startMovingRemoteTime()
    this.set("moved",false)

  mouseMove: ->
    this.set("moved",true)

  click: ->
    #remove only if clicked, not while after moving
    if( ! this.get("moved") )
      this.set("moved",false)
      Sliders.TimeController.clearRemoteTime()