@Sliders.Clock = Ember.Object.extend
  timezone: 0
  days_shift: 0
  phase:  0

  clock: (->
    time = @get("utc") + 
      (@get("timezone") * 1000) - 
      (@get("phase") * 60 * 1000) + 
      (@get("days_shift") * 24 * 60 * 60 * 1000)
    date = new Date( time )
    
    #round
    if mod = @get("round")
      m = date.getMinutes() 
      date.setMinutes(m - m % mod) 

    date
  ).property("phase")

  hour24: (->
    @_timeFormat @get("clock").getHours()
  ).property("clock")

  hour: (->
    hour = @get("clock").getHours()
    hour = hour - 12 if (hour > 12)  
    hour = 12 if (hour == 0) 
    @_timeFormat hour
  ).property("clock")

  minutes: (->
    @_timeFormat @get("clock").getMinutes()
  ).property("clock")
  
  ampm: (->
    if @get("hour24") > 11 then "PM" else "AM"
  ).property("clock")

  dayName: (-> 
    myDays = ["Sun","Mon","Tue","Wed","Thu","Fri","Sat","Sun"]
    myDays[ @get("clock").getDay() ]
  ).property("clock")
  
  month: (-> 
    myMonths = [
      "Jan","Feb","Mar"
      "Apr","May","Jun"
      "Jul","Aug", "Sep"
      "Oct","Nov","Dec"
    ]
    myMonths[ @get("clock").getMonth() ]
  ).property("clock")

  year: (->
    @get("clock").getFullYear()
  ).property()
  
  dayNumber: (-> 
    num = @get("clock").getDate()
    if num < 10 then "0"+num else num
  ).property("clock")

  _timeFormat: (number)->
    if(number < 10) then '0'+number else number

  formattedTime: (->
    #spec: 10:25PM / SAT NOV 03 2012
    [
      @get("hour"),
      ":",
      @get("minutes"),
      @get("ampm"),
      " / ",
      @get("dayName").toUpperCase(),
      " ",
      @get("month").toUpperCase(),
      " ",
      @get("dayNumber"),
      " ",
      @get("year")
    ].join("")  
  ).property("clock").cacheable()

  utc: (-> 
    d = new Date()
    d.getTime() + (d.getTimezoneOffset() * 60 * 1000)
  ).property()