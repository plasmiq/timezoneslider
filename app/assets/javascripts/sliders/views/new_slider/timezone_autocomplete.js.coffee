@Sliders.TimeZoneAutoComplete = Ember.TextField.extend      
  source: "timezones/search.js"

  didInsertElement: ->
    options = {}
    for opt in ['source','select','focus']
      options[opt] = @get(opt)
    ui = new jQuery.ui["autocomplete"](options, this.get('element'))
    this.set("ui", ui)
   
  select: ( event, ui ) ->
    if ( ui.item ) 
      view = Ember.View.views[ event.target.id ]._parentView;
      view.set("location", ui.item.label)
      view.set("timezone", ui.item.value)
    event.preventDefault();
    
  focus: ( event, ui ) ->
    event.preventDefault()
  
