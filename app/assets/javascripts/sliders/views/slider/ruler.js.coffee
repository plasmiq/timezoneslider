@Sliders.RulerView = Ember.View.extend
  templateName: 'sliders/templates/slider/ruler'
  classNames: ['timeline']
  
  timezoneBinding: 'parentView.content.timezone'  
 
  hours: [0..23]
  
  didInsertElement: ->
    @updateHours()
  
  updateHours: (->
    shift = Sliders.LocalTimeController.getHoursShift( @get("timezone") )
    s = Math.ceil(shift) 
    h = @get("hours")
    hours = h[0..23] if s == 0
    hours = h[s..23].concat h[0..s-1] if s != 0
    #hours = h[s..23].concat h[0..s-1] if s < 0
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
    
    ruler_width = 790;
    position = (e.pageX - CalculatedTotalOffsetLeft)/790.0
    
    Sliders.RemoteTimeController.updateRemoteTime( position )
    e.stopPropagation()
