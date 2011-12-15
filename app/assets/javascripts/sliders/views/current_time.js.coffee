@Sliders.CurrentTimeView = SC.View.extend
  timezoneBinding: 'parentView.timezone'
  timerBinding: "Sliders.TimerController.hasChanged"
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
      
  hour: (->
    hour = this.get("time").getHours();
    hour = hour - 12 if (hour   > 12)  
    hour = 12 if (hour   == 0) 
    @_timeFormat hour
  ).property "time"
  
  minutes: (->
    m = this.get("time").getMinutes();
    @_timeFormat m
  ).property("time").cacheable()
  
  s: (->
    this.get("time").getSeconds();
  ).property("time")
