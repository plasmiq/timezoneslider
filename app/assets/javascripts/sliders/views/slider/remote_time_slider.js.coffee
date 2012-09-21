@Sliders.RemoteTimeSliderView = Sliders.CurrentTimeSliderView.extend
  classNames: ['remoteTimeSlider']
  minutesTodayBinding: "Sliders.TimeController.remoteMinutes"
  moved: false

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

  phase: (->
    @get("minutesToday")
  ).property("minutesToday")
  
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