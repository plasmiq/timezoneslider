@Sliders.TimeController = Ember.Object.create
  remoteMinutes: null

  _isMovingRemoteTime: false

  localMinutes: (->
    d = new Date()
    d.getHours() * 60 + d.getMinutes()
  ).property()

  startTicking: ->
    Sliders.SlidersController.content.forEach (slider)->
      slider.updateClock()
    setTimeout(Sliders.TimeController.startTicking,1000);

  getHoursShift: (shift) ->
    remote = shift
    local = (new Date()).getTimezoneOffset() * (-60) 
    ( remote - local ) / 3600
  
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