@Sliders.SliderView = Ember.View.extend
  templateName: 'sliders/templates/slider/slider'
  classNameBindings: ["color"]
  classNames: ["slider"]

  color: (-> 
  	"color"+ ( @get("contentIndex") % 4 )
  ).property("contentIndex")

  remove: (evt) ->
    Sliders.SlidersController.removeSlider( this.get("content") );