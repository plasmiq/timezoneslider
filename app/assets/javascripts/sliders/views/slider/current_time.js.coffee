@Sliders.CurrentTimeView = Ember.View.extend
  updateClock: (->
    @get("parentView").get("content").updateClock(@get("phase"))
  ).observes("timer","phase")