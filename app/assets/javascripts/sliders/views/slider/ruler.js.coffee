@Sliders.RulerView = Ember.View.extend
  templateName: 'sliders/templates/slider/ruler'
  classNames: ['timeline']
  hours: [0..23]
  
  controller: Sliders.TimeController

  didInsertElement: ->
    shift = @get("controller").getHoursShift( @get("timezone") )
    s = Math.ceil(shift) 
    #Rotate the hours for express timezone
    @set("hours", (@get("hours")[s..23].concat @get("hours")[0..s-1])) if s != 0
    #If timezone shift is not full hour then hours starts with '-'
    if shift % 1 != 0 
      this.$().addClass("halfhour")
      @set("hours", ["-"].concat @get("hours") )
  
  mouseDown: ->
    @get("controller").startMovingRemoteTime()

  mouseUp: ->
    @get("controller").stopMovingRemoteTime()

  mouseMove: (e) ->
    @move(e) if @get("controller").isMovingRemoteTime() 
      
  click: (e) ->
    @move(e)

  move: (e) ->
    #Any ruler on screen will do, as we want: X position, width
    ruler = $(".timeline")

    #Calucate where specificly ruler was clicked on
    position = ( e.pageX - ruler.offset().left ) / ruler.width()
    
    @get("controller").updateRemoteTime( position )
    e.stopPropagation()