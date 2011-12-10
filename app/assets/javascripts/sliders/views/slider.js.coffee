@Sliders.SliderView = SC.View.extend({
  templateName: 'sliders/slider'
  contentBinding: 'parentView.content'
  timezoneBinding: 'parentView.content.timezone'
  
  remove: (evt) ->
    Sliders.slidersController.removeSlider( this.get("content").get("id") );
})

