@Sliders.RulerView = Ember.View.extend
  templateName: 'sliders/templates/slider/ruler'
  classNames: ['timeline']
  
  timezoneBinding: 'parentView.content.timezone'  
 
  hours: [0..23]
  
  didInsertElement: ->
    @updateHours()
  
  updateHours: (->
    shift = Sliders.TimeController.getHoursShift( @get("timezone") )
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
    #Any ruler on screen will do as we want only X position and its width
    ruler = $(".timeline")

    #Calucate where specificly ruler was clicked on
    position = ( e.pageX - ruler.offset().left ) / ruler.width()
    
    Sliders.TimeController.updateRemoteTime( position )
    e.stopPropagation()