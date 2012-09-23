@Sliders.RemoteTimeSliderView = Sliders.CurrentTimeSliderView.extend
  classNames: ['remoteTimeSlider']
  minutesTodayBinding: "controller.remoteMinutes"
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

  mouseUp: ->
    @get("controller").stopMovingRemoteTime()
  
  mouseDown: ->
    @get("controller").startMovingRemoteTime()
    @set("moved",false)

  mouseMove: ->
    @set("moved",true)

  click: ->
    #remove only if clicked, not while after moving
    if( ! @get("moved") )
      @set("moved",false)
      @get("controller").clearRemoteTime()