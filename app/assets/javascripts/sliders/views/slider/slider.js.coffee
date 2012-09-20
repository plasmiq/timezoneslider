@Sliders.SliderView = Ember.View.extend
  templateName: 'sliders/templates/slider/slider'
  
  classNames: ["slider"]

  remove: (evt) ->
    Sliders.SlidersController.removeSlider( this.get("content") );