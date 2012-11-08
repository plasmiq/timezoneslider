@Sliders.SyncButtonView = Em.View.extend

	classNames: ["sync_button"]

	tagName: "a"

	slidersBinding:  "Sliders.SlidersController"

	attributeBindings: ["href"]

	href: (->
		"mailto:" + 
			"?subject=" + @get("subject") +
			"&body=" + @get("body")
	).property("sliders")

	subject: (->
		"Let's sync when the time is right"
	).property()

	body: (-> 
		new_line = "%0D%0A"
		space = " "
		tab = "	"
		hr = "#################################"

		text = [
			"Hi there!" + new_line,
			"Let me know if this time works for us to sync up:",
			new_line+new_line,
		].join(new_line)

		@get("sliders").forEach (slider) ->
			text += [
				hr + new_line,
				slider.get("name") + " : " + slider.get("location"),
				"SYNC TIME : " + slider.get("remoteClock").get("formattedTime")
				new_line
			].join(new_line)

		text += [
			hr,
			new_line,
			"-- ",
			"time syncing with your friends, visit timezoneslider.com"
		].join(new_line)
	).property()