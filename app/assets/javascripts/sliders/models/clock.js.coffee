@Sliders.Clock = Ember.Object.extend
	timezone: 0
	phase:  0
	clock: null

	init: ->
		@set("clock", new Date( @get("date") + (@get("timezone")*1000) + (@get("phase") * 60 * 1000 ) ) )

	date: (->
		d = new Date()
		d.getTime() + (d.getTimezoneOffset() * 60000)
	).property()

	_timeFormat: (number)->
		if(number < 10) then '0'+number else number

	hour24: (->
		@get("clock").getHours();
	).property("clock","phase")

	hour: (->
		hour = @get("clock").getHours();
		hour = hour - 12 if (hour   > 12)  
		hour = 12 if (hour   == 0) 
		@_timeFormat hour
	).property("clock","phase")

	minutes: (->
		@_timeFormat @get("clock").getMinutes();
	).property("clock","phase").cacheable()
	
	ampm: (->
    if @get("hour24")  > 11 then "PM" else "AM"
  ).property("clock","phase")

  dayName: (-> 
    time = @get("clock")
    myDays = ["Sun","Mon","Tue","Wed","Thu","Fri","Sat","Sun"]
    myDays[ time.getDay() ]
  ).property("clock","phase")
  
  month: (-> 
    time = @get("clock")
    myMonths = [
      "Jan","Feb","Mar"
      "Apr","May","Jun"
      "Jul","Aug", "Sep"
      "Oct","Nov","Dec"
    ]
    myMonths[ time.getMonth() ]
  ).property("clock","phase")
  
  dayNumber: (-> 
    time = @get("clock")
    num = time.getDate()
    if num < 10 then "0"+num else num
  ).property("clock","phase")