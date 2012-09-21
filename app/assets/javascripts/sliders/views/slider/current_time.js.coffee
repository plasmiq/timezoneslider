@Sliders.CurrentTimeView = Ember.View.extend
  updateSliders: (->
    @get("parentView").get("content").set("phase", @get("phase") ) 
    @get("parentView").get("content").updateClock()
  ).observes("phase")