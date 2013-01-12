@Sliders.SliderView = Ember.View.extend
  templateName: 'sliders/templates/slider/slider'
  classNameBindings: ["color"]
  classNames: ["slider"]

  color: (-> 
  	"color"+ ( @get("_parentView.contentIndex") % 4 )
  ).property()

  remove: (evt) ->
  	that = this.$().hide() #workaraound in case you hade reordered sliders list
  	Sliders.SlidersController.removeSlider( this.get("content") );