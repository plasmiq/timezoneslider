@Sliders.Slider = Ember.Object.extend
	name: null
	location: null
	timezone: null
	localClock:  null
	remoteClock: null

	id: (->
		return this.get("name")+this.get("timezone")
	).property()

	updateClock: ->
		@set("localClock", 
			Sliders.Clock.create( {
				timezone: @get("timezone") 
			} ) 
		)
		@set("remoteClock", 
			Sliders.Clock.create( { 
				timezone: @get("timezone"),
				phase: @get("phase")
			} ) 
		)