@Sliders.TimeZoneAutoComplete = Ember.TextField.extend      
  didInsertElement: ->
    options = {}
    for opt in ['source','select','focus']
      options[opt] = @get(opt)
    ui = new jQuery.ui["autocomplete"](options, this.get('element'))
    this.set("ui", ui)
  
  source: "timezones/search.js"
  
   
  select: ( event, ui ) ->
    if ( ui.item ) 
      Sliders.SlidersController.set("newSliderLocation", ui.item.label)
      Sliders.SlidersController.set("newSliderTimezone", ui.item.value)
      event.preventDefault();
    
  focus: ( event, ui ) ->
    event.preventDefault()
  
