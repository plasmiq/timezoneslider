@Sliders.SlidersController = Ember.ArrayController.create
  content: []

  createSlider: (name, location, timezone) ->
    slider = Sliders.Slider.create({
      name: name,
      timezone: timezone,
      location: location
    });

    @pushObject(slider);
  
  removeSlider: (slider) ->
    @content.removeObject( slider )

  updateSliders: ->
    @get("content").forEach (slider)->
      slider.updateClock()