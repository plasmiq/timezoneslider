@Sliders.TimeController = Ember.Object.create
  mode: "12"
  days_shift: 0
  localMinutes: null
  remoteMinutes: null
  _isMovingRemoteTime: false

  isDaysShift: (->
    @get("days_shift") != 0
  ).property("days_shift")

  isMode12: (->
    @get("mode") == "12"
  ).property("mode")

  nextDay: ->
    @set "days_shift", @get("days_shift") + 1

  prevDay: ->
    @set "days_shift", @get("days_shift") - 1

  changeMode: ->
    @set "mode", if @get "isMode12" then "24" else "12"

  updateTime: (->
    d = new Date()
    @set("localMinutes", 30 + d.getHours() * 60 + d.getMinutes() )
    time_shift = @get("localMinutes") - @get("remoteMinutes")
    Sliders.SlidersController.updateSliders( time_shift, @get("days_shift") )
  ).observes("localMinutes","remoteMinutes","days_shift")

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