@Sliders.CurrentTimeView = Ember.View.extend
  timezoneBinding: 'parentView.content.timezone'
  timerBinding: "Sliders.TimeController.hasChanged"
  phase: 0 
  
  date: (->
    d = new Date()
    d.getTime() + (d.getTimezoneOffset() * 60000)
  ).property()
  
  time: (->
    new Date( @get("date") + (this.get("timezone")*1000) + (this.get("phase") * 60 * 1000 ) ) 
  ).property("timer")
  
  _timeFormat: (number)->
    if(number < 10) then '0'+number else number
 
  hour24: (->
    @get("time").getHours();
  ).property("time","phase")

  hour: (->
    hour = this.get("time").getHours();
    hour = hour - 12 if (hour   > 12)  
    hour = 12 if (hour   == 0) 
    @_timeFormat hour
  ).property("time","phase")
  
  minutes: (->
    m = this.get("time").getMinutes();
    @_timeFormat m
  ).property("time","phase").cacheable()
  
  s: (->
    this.get("time").getSeconds();
  ).property("time","phase")
