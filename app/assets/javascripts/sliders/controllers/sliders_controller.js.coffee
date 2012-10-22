@Sliders.SlidersController = Ember.ArrayController.create
  content: Sliders.Store.findAll(Sliders.Slider).toArray()

  createSlider: (name, location, timezone) ->
    store = Sliders.Store
        
    slider = Sliders.Slider.createRecord 
      name:     name
      timezone: timezone
      location: location

    store.commit();
    slider.updateClock(0) #need a fix
    @pushObject slider
  
  removeSlider: (slider) -> 
  	store = Sliders.Store
  	store.deleteRecord( slider )
  	store.commit();
  	@popObject(slider)

  updateSliders: (phase) ->
  	@get("content").forEach (slider) -> 
  		slider.updateClock(phase)