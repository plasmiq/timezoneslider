@Sliders.SlidersController = Ember.ArrayController.create
  content: Sliders.Store.findAll(Sliders.Slider).toArray().sort (a,b) ->
    (a.get("position") || 100 ) > ( b.get("position") || 100 )

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
  	@removeObject(slider)

  updateSliders: (phase, days_shift) ->
  	@get("content").forEach (slider) -> 
  		slider.updateClock(phase,days_shift)

  updateOrder: (newOrder) ->
    for num in [0..newOrder.length - 1]
      Sliders.Slider.find(newOrder[num]).set "position", num+1
    Sliders.Store.commit()