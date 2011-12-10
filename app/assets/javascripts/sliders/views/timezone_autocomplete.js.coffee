@Sliders.TimeZoneAutoComplete = SC.TextField.extend

  _gatherEvents: (options) ->
    events = ['select','focus']
    self = this;
    for event in events
      callback = self[event];
  
      if (callback) 
        options[event] = (event, ui) -> 
          callback.call(self, event, ui)
         
      
  didInsertElement: ->
    this._super();
    
    options = {}
    options["source"] = this.get("source")
    this._gatherEvents(options);
    ui = new jQuery.ui["autocomplete"](options, this.get('element'))
    this.set("ui", ui)
  
  source: "timezones/search.js"
  
  placeholder: "Type you location",
  
  selectTarget: "parentView.content"
  
  selectAction: (t, val) ->
    this.set("placeholder","test")
     
  select: ( event, ui ) ->
    window.alert("test")
    if ( ui.item ) 
      target = SC.getPath(this.get('selectTarget'));
      target[this.get('selectAction')].call(target, ui.item.value)
      event.target.value = '';
      event.preventDefault();
    
  focus: ( event, ui ) ->
    event.preventDefault()
  
