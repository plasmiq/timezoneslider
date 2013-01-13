@Sliders.CurrentTimeNotifierView = Ember.View.extend
  templateName: "sliders/templates/slider/current_time_notifier"
  classNames: ['currentTimeNotifier']
  
  classNameBindings: ['remote']

  remoteBinding: "controller.isRemote"
  
  controller: Sliders.TimeController

  isHidden: (->
    @get("controller.isDaysShift") && ! @get("remote")
  ).property("remote","controller.isDaysShift")

  clock: (->
    if @get("remote")
      @get("remoteClock")
    else
      @get("localClock")
  ).property("remoteClock")

  click: ->
    @get("controller").changeMode()