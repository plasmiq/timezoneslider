@Sliders.TimeController = Ember.Object.create
  mode: "12"
  localMinutes: null
  remoteMinutes: null
  _isMovingRemoteTime: false

  isMode12: (->
    @get("mode") == "12"
  ).property("mode")

  changeMode: ->
    mode = "12"
    if @get("mode") == "12"
      mode = "24"
    @set("mode", mode) 

  updateTime: (->
    d = new Date()
    @set("localMinutes", 30 + d.getHours() * 60 + d.getMinutes() )
    Sliders.SlidersController.updateSliders(@get("localMinutes") - @get("remoteMinutes") )
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
    @set("_isMovingRemoteTime",true)
  
  stopMovingRemoteTime: ->
    @set("_isMovingRemoteTime",false)

  isMovingRemoteTime: ->
    @get("_isMovingRemoteTime")

  isRemote: (->
    @get("remoteMinutes") > 0
  ).property("remoteMinutes")