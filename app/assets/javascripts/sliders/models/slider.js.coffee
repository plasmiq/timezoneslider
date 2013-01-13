@Sliders.Slider = DS.Model.extend
	name: DS.attr('string')
	location: DS.attr('string')
	timezone: DS.attr('string')
	position: DS.attr('number')
	localClock:  null
	remoteClock: null

	updateClock: (phase, days_shift)->
		@set("localClock",
			Sliders.Clock.create
				timezone: @get("timezone") 
				days_shift: days_shift
		)
		@set("remoteClock", 
			Sliders.Clock.create
				timezone: @get("timezone")
				phase: phase
				round: 5
				days_shift: days_shift
		)