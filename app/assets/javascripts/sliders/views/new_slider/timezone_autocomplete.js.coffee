@Sliders.TimeZoneAutoComplete = Ember.TextField.extend      
  source: "timezones/search.js"

  didInsertElement: ->
    options = {}
    for opt in ['source','select','focus']
      options[opt] = @get(opt)
      
    options.search = -> 
      $("#new_slider_button").addClass('working')
    options.open = -> 
      $("#new_slider_button").removeClass('working')

    jQuery.ui.autocomplete.prototype._renderItem = (ul, item) ->
      name = item['label']
      timezone = item['timezone']
      offset = item['value'] / 60 / 60
      offset = "+"+offset if offset > 0
      return $("<li></li>")
        .data("item.autocomplete", item)
        .append("<a><p>"+name+"</p><span>"+timezone+"<strong>UTC: "+offset+"</strong></span></a>")
        .appendTo(ul);

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