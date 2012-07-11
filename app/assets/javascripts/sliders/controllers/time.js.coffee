@Sliders.TimeController = Ember.Object.create({
  hasChanged: 0
  remoteMinutes: null

  localMinutes: (->
    d = new Date()
    d.getHours() * 60 + d.getMinutes()
  ).property()

  startTicking: ->
    Sliders.TimeController.set("hasChanged", Sliders.TimeController.get("hasChanged") + 1 );
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
    
  
});
