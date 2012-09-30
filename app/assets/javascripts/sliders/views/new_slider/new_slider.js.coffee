@Sliders.NewSliderView = Ember.View.extend
  templateName: 'sliders/templates/new_slider/new_slider',
  name: null,
  location: null,
  timezone: null,
  tagName: "div"

  createSlider: ->
    unless @get("timezone") == null
     	Sliders.SlidersController.createSlider(
     	  @get("name")
     	  @get("location")
     	  @get("timezone") 
      )
      @set("name",null);
      @set("location",null);
      @set("timezone",null);
      $("#friend_name").focus()
    else
      $("#city_autocomplete").effect("shake",{ times:2, distance: 3 }, 100)

  keyUp: (e) ->
    @createSlider() if (e.which == 13)