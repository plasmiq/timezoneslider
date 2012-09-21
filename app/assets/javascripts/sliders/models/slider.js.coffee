@Sliders.Slider = Ember.Object.extend
	name: null
	location: null
	timezone: null
	localClock:  null
	remoteClock: null

	id: (->
		return this.get("name")+this.get("timezone")
	).property()

	init: -> 
		@set("localClock", 
			Sliders.Clock.create( {
				timezone: @get("timezone") 
			} ) 
		)

	updateClock: (phase)->
		@set("remoteClock", 
			Sliders.Clock.create( { 
				timezone: @get("timezone"),
				phase: phase 
			} ) 
		)