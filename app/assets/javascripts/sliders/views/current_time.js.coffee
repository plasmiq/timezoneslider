@Sliders.CurrentTimeView = SC.View.extend({
  timezoneBinding: 'parentView.timezone'
  timerBinding: "Sliders.TimerController.hasChanged"
  phase: 0 
  
  time: (->
    d = new Date()
    utc = d.getTime() + (d.getTimezoneOffset() * 60000)
    return ( 
      new Date( utc + (this.get("timezone")*1000) + (this.get("phase")*1000) ) 
    )
  ).property("timer")
  
  hours: (-> 
    h = this.get("time").getHours();
    if (h < 10) 
      h = '0'+h;    
    h
  ).property("time")
  
  hour: (->
    hour = this.get("hours");
    hour = hour - 12 if (hour   > 12)  
    hour = 12 if (hour   == 0) 
    hour
  ).property "hours"
  
  minutes: (->
    m = this.get("time").getMinutes();
    if(m < 10)
      m = '0'+m;    
    m
  ).property("time")
  
  seconds: (->
    this.get("time").getSeconds()
  ).property("time")
});

