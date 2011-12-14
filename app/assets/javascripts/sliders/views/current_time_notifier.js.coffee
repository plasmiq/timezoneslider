@Sliders.CurrentTimeNotifierView = Sliders.CurrentTimeView.extend({
  classNames: ['currentTimeNotifier']
  
  templateName: "sliders/current_time_notifier"
  
  locationBinding: "parentView.location"
     
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
    num = time.getDate()
    if num < 10 then "0"+num else num
  ).property "hours"
})
