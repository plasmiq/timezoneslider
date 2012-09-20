@Sliders.CurrentTimeNotifierView = Sliders.CurrentTimeView.extend
  classNames: ['currentTimeNotifier']
  classNameBindings: ['remote']
  
  templateName: "sliders/templates/slider/current_time_notifier"

  controller: Sliders.TimeController

  remote: (->
    @get("controller").get("remoteMinutes") > 0
  ).property("controller.remoteMinutes")

  phase: (->
    if @get("remote")
      @get("controller").get("remoteMinutes")
    else
      0
  ).property("remote")

  ampm: (->
    if this.get("hour24")  > 11 then "PM" else "AM"
  ).property "hour24"
  
  dayName: (-> 
    myDays = ["Sun","Mon","Tue","Wed","Thu","Fri","Sat","Sun"]
    time = this.get "time"
    myDays[ time.getDay() ]
  ).property "hour"
  
  month: (-> 
    myMonths = [
      "Jan","Feb","Mar"
      "Apr","May","Jun"
      "Jul","Aug", "Sep"
      "Oct","Nov","Dec"
    ]
    time = this.get "time"
    myMonths[ time.getMonth() ]
  ).property "hour"
  
  dayNumber: (-> 
    time = this.get "time"
    num = time.getDate()
    if num < 10 then "0"+num else num
  ).property "hour"