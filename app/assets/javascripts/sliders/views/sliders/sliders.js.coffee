@Sliders.SlidersView = Ember.View.extend
	classNames: ['sliders']

	templateName: 'sliders/templates/sliders/sliders'

	controller: Sliders.SlidersController

	didInsertElement: ->
		this._super();
		that = this
		$("#sliders_list").sortable
			handle: ".handle"
			axis: "y"
			opacity : 0.6
			update: (event, ui) ->
	            newOrder = $("#sliders_list").sortable('toArray').filter (elem) ->
	            	elem.indexOf("ember") != -1
	            newOrder = newOrder.map (elem) ->
	            	$("#"+elem).find(".name").attr("data-id")
	            Sliders.SlidersController.updateOrder(newOrder)
        