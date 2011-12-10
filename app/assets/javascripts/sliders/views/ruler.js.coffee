@Sliders.RulerView = SC.View.extend({
  templateName: 'sliders/ruler'
  classNames: ['timeline']
  
  timezoneBinding: 'parentView.content.timezone'  
 
  hours: [0..23]
  
  didInsertElement: ->
    @updateHours()
  
  updateHours: (->
    shift = Sliders.LocalTimeController.getHoursShift( @get("timezone") )
    s = Math.ceil(shift) 
    h = @get("hours")
    hours = h[s..23]
    hours = hours.concat h[0..s-1] if s > 0
    @set("hours", hours )    
    if shift % 1 != 0 
      this.$().addClass("halfhour")
      @set("hours", ["-"].concat @get("hours") )
  )
  
  click: (e) ->
    Element = e.target;
    CalculatedTotalOffsetLeft = 0
    while Element.offsetParent
      CalculatedTotalOffsetLeft += Element.offsetLeft
      Element = Element.offsetParent

    Sliders.RemoteTimeController.updateRemoteTime(e.pageX - CalculatedTotalOffsetLeft)

})
