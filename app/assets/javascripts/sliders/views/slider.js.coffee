@Sliders.SliderView = SC.View.extend({
  templateName: 'sliders/slider'
  contentBinding: 'parentView.content'
  timezoneBinding: 'parentView.content.timezone'
  locationBinding: 'parentView.content.location'
  
  remove: (evt) ->
    Sliders.SlidersController.removeSlider( this.get("content").get("id") );
})

