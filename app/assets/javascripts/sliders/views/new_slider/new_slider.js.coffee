@Sliders.NewSliderView = Ember.View.extend
  templateName: 'sliders/templates/new_slider/new_slider',
  name: null,
  location: null,
  timezone: null,
  createSlider: ->
   	Sliders.SlidersController.createSlider( 
   	  this.get("name"), 
   	  this.get("location"), 
   	  this.get("timezone") );
    this.set("name",null);
    this.set("location",null);
    this.set("timezone",null);