@Sliders.TimeController = Ember.Object.create
  localMinutes: null
  remoteMinutes: null
  _isMovingRemoteTime: false

  updateTime: (->
    d = new Date()
    @set("localMinutes", 30 + d.getHours() * 60 + d.getMinutes() )
    Sliders.SlidersController.content.forEach (slider)->
      phase = Sliders.TimeController.get("localMinutes") - Sliders.TimeController.get("remoteMinutes")
      slider.set("phase", - phase ) 
      slider.updateClock()
  ).observes("localMinutes","remoteMinutes")

  startTicking: ->
    Sliders.TimeController.updateTime()
    setTimeout(Sliders.TimeController.startTicking,1000);

  getHoursShift: (remote) ->
    local = (new Date()).getTimezoneOffset() * (-60) 
    ( remote - local ) / (60 * 60)
  
  updateRemoteTime: ( position ) ->
    m = position * 60 * 24
    @set("remoteMinutes", m)

  clearRemoteTime: ->
  	@set("remoteMinutes", null)
    
  startMovingRemoteTime: ->
    this.set("_isMovingRemoteTime",true)
  
  stopMovingRemoteTime: ->
    this.set("_isMovingRemoteTime",false)

  isMovingRemoteTime: ->
    return this.get("_isMovingRemoteTime")