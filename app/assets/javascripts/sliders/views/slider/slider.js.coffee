@Sliders.SliderView = Ember.View.extend
  templateName: 'sliders/templates/slider/slider'
  contentBinding: 'parentView.content'
  timezoneBinding: 'parentView.content.timezone'
  locationBinding: 'parentView.content.location'
  
  remove: (evt) ->
    Sliders.SlidersController.removeSlider( this.get("content") );
    
  click: ->
    Sliders.RemoteTimeController.set("minutesToday",null)
