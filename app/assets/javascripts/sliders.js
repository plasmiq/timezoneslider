Sliders = Ember.Application.create();

Sliders.SlidersController = Ember.ArrayProxy.create({
  content: [],
  newSliderName: null,
  newSliderTimezone: null,
  newSliderLocation: null,

  createSlider: function() {
    var slider = Sliders.Slider.create({
      name: this.get("newSliderName"),
      timezone: this.get("newSliderTimezone"),
      location: this.get("newSliderLocation")
    });

    this.pushObject(slider);
    
    this.set("newSliderName",null);
    this.set("newSliderTimezone",null);
    this.set("newSliderLocation",null);
  },
  removeSlider: function(slider) {

     this.forEach(function(item) {
      if(item.get("id") === slider.get("id")) {
        this.popObject(item);
      }
    }, this);
  }
  
});

Sliders.SlidersView = Ember.CollectionView.extend({
  contentBinding: "Sliders.SlidersController",
});

$(function() {
  Sliders.Slider.resourceName = 'sliders';
  Sliders.TimerController.startTicking();
})