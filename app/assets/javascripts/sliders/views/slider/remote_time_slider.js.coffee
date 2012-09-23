@Sliders.RemoteTimeSliderView = Sliders.CurrentTimeSliderView.extend
  classNames: ['remoteTimeSlider']
  minutesTodayBinding: "controller.remoteMinutes"
  moved: false

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