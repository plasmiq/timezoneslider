@Sliders.AvailabilityView = Ember.View.extend
	template: Ember.Handlebars.compile("<div class='left'></div><div class='right'></div>")
	classNames: ["hour"]
	classNameBindings: ['availability']

	availability: (->
		hour = Number( @get("content") )
		"ok" if (hour >= 8) && (hour <= 20) 
	).property()