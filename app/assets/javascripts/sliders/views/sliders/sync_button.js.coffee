@Sliders.SyncButtonView = Em.View.extend

	classNames: ["sync_button"]

	tagName: "a"

	slidersBinding:  "Sliders.SlidersController"

	attributeBindings: ["href", "target"]

	target: "_blank"

	controller: Sliders.TimeController

	href: (->
		"mailto:" + 
			"?subject=" + @get("subject") +
			"&body=" + @get("body")
	).property("sliders.@each.remoteClock")

	subject: (->
		"Sync times - Timezoneslider"
	).property()

	body: (-> 
		new_line = "%0D%0A"
		space = " "
		tab = "	"
		hr = "-------------------------------------"

		text = [
			"Hi there!" + new_line,
			"Let me know if this time works for us to sync up:",
			new_line,
		].join(new_line)

		@get("sliders").forEach (slider) ->
			text += [
				hr,
				slider.get("name").toUpperCase() + ":",
				slider.get("location").toUpperCase(),
				hr,
				"SYNC TIME:",
				slider.get("remoteClock").get("formattedTime"),
				hr + new_line
			].join(new_line)

		text += [
			new_line,
			"-- "+new_line,
			"Time sync with your friends around the world at http://timezoneslider.com"
		].join(new_line)
	).property("sliders.@each.remoteClock")