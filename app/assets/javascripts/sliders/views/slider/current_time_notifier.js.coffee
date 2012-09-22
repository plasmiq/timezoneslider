@Sliders.CurrentTimeNotifierView = Ember.View.extend
  templateName: "sliders/templates/slider/current_time_notifier"
  classNames: ['currentTimeNotifier']
  classNameBindings: ['remote']
  
  controller: Sliders.TimeController

  clock: (->
    if @get("remote")
      @get("remoteClock")
    else
      @get("localClock")
  ).property("remoteClock")

  remote: (->
    @get("controller").get("remoteMinutes") > 0
  ).property("remoteClock")