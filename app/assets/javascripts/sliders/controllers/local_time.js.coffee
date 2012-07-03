@Sliders.LocalTimeController = Ember.Object.create 
  getHoursShift: (shift) ->
    remote = shift
    local = (new Date()).getTimezoneOffset() * (-60) 
    ( remote - local ) / 3600
    
  minutesToday: (->
    d = new Date()
    d.getHours() * 60 + d.getMinutes()
  ).property()
