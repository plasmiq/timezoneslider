@Sliders.CurrentTimeNotifierView = Sliders.CurrentTimeView.extend({
  classNames: ['currentTimeNotifier']
  
  templateName: "sliders/current_time_notifier"
  
  locationBinding: "parentView.timezone"
  
  hour: (->
    hour = this.get("hours");
    hour = hour - 12 if (hour   > 12)  
    hour = 12 if (hour   == 0) 
    hour
  ).property "hours" 
  
  tickerClass: (->
    if this.get("seconds") % 2 then "invisible" else "s"
  ).property "seconds"
  
  ampm: (->
    if this.get("hours")  > 11 then "PM" else "AM"
  ).property "hours"
  
  dayName: (-> 
    myDays = ["Sun","Mon","Tue","Wed","Thu","Fri","Sat","Sun"]
    time = this.get "time"
    myDays[ time.getDay() ]
  ).property "hours"
  
  month: (-> 
    myMonths = [
      "Jan","Feb","Mar"
      "Apr","May","Jun"
      "Jul","Aug", "Sep"
      "Oct","Nov","Dec"
    ]
    time = this.get "time"
    myMonths[ time.getMonth() ]
  ).property "hours"
  
  dayNumber: (-> 
    time = this.get "time"
    num = time.getDay()
    if num < 10 then "0"+num else num
  ).property "hours"
})
