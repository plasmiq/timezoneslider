@Sliders.SlidersController = Ember.ArrayController.create
  content: []

  createSlider: (name, location, timezone) ->
    @pushObject Sliders.Slider.create
      name:     name
      timezone: timezone
      location: location
  
  removeSlider: (slider) -> @content.removeObject slider 

  updateSliders: ->
    @get("content").forEach (slider) -> slider.updateClock