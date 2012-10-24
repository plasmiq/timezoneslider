@Sliders.AvailabilityView = Ember.View.extend
	template: Ember.Handlebars.compile("<div class='left'></div><div class='right'></div>")

	classNameBindings: ['availability']

	availability: (->
		hour = Number( @get("content") )
		if (hour >= 1) && (hour <= 1)
			"ok hour" 
		else
			"hour"
	).property()