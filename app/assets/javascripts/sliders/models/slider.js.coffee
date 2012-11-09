@Sliders.Slider = DS.Model.extend
	name: DS.attr('string')
	location: DS.attr('string')
	timezone: DS.attr('string')
	localClock:  null
	remoteClock: null

	updateClock: (phase)->
		@set("localClock",
			Sliders.Clock.create
				timezone: @get("timezone") 
		)
		@set("remoteClock", 
			Sliders.Clock.create
				timezone: @get("timezone")
				phase: phase
				round: 5
		)