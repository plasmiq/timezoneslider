@Sliders.TimeZoneAutoComplete = SC.TextField.extend      
  didInsertElement: ->
    options = {}
    for opt in ['source','select','focus']
      options[opt] = @get(opt)
    ui = new jQuery.ui["autocomplete"](options, this.get('element'))
    this.set("ui", ui)
  
  source: "timezones/search.js"
  
  placeholder: "Type you location",
   
  select: ( event, ui ) ->
    if ( ui.item ) 
      event.target.value = ui.item.value;
      event.preventDefault();
    
  focus: ( event, ui ) ->
    event.preventDefault()
  
