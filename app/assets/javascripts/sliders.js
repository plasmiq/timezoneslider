Sliders = SC.Application.create({
  store: SC.Store.create({commitRecordsAutomatically: true}).from('SB.RestDataSource')
});

Sliders.Slider = SC.Record.extend({
  primaryKey: 'id',

  // Attributes
  name: SC.Record.attr(String, {isRequired: true}),
  timezone: SC.Record.attr(String, {defaultValue: false}),
  
});

Sliders.Slider.resourceName = 'sliders';

Sliders.slidersController = SC.ArrayProxy.create({
  content: [],
  newSliderName: null,
  newSliderTimezone: null,
  loadSliders: function() {
    var query = SC.Query.local(Sliders.Slider, {orderBy: 'created_at DESC'}),
        data = Sliders.store.find(query);
    data.addObserver('status', this, function observer() {
      if (data.get('status') === SC.Record.READY_CLEAN) {
        data.removeObserver('status', this, observer);
        this.set('content', data);
      }
    });
    
    // in case our data was already loaded (ie synchronous)
    data.notifyPropertyChange('status');
  },
  createSlider: function() {
    //var store = Todos.store.chain();
    var storeKey = Sliders.store.createRecord(Sliders.Slider, {
      name: this.get("newSliderName"),
      timezone: this.get("newSliderTimezone")
    });
    //store.commitChanges(true);
    this.set("newSliderName",null);
    this.set("newSliderTimezone",null);
  },
  removeSlider: function(id) {
     this.forEach(function(slider) {
      if(slider.get("id") === id) {
        slider.destroy();
      }
    }, this);
  }
  
});

Sliders.CreateSliderView = SC.View.extend({
  templateName: 'sliders/new_slider'
});

Sliders.SlidersView = SC.CollectionView.extend({
  contentBinding: "Sliders.slidersController",
});

Sliders.SliderView = SC.View.extend({
  templateName: 'sliders/slider',
  contentBinding: 'parentView.content',
  remove: function(evt){
    Sliders.slidersController.removeSlider( this.get("content").get("id") );
  }
});

Sliders.Timer = SC.Object.create({
  hasChanged: 0,
  startTicking: function() {
    Sliders.Timer.set("hasChanged", Sliders.Timer.get("hasChanged") + 1 );
    setTimeout(Sliders.Timer.startTicking,1000);
  }
});

Sliders.Timer.startTicking();

Sliders.CurrentTimeView = SC.View.extend({
  timezoneBinding: 'parentView.content.timezone',
  template: SC.Handlebars.compile("{{hours}}<br/>{{minutes}}<br/>{{seconds}}"),
  timerBinding: "Sliders.Timer.hasChanged",
  classNames: ['currentTime'],
  time: function() {
    var d = new Date();
    var utc = d.getTime() + (d.getTimezoneOffset() * 60000)
    return (new Date(utc + (this.get("timezone")*1000)) );
  }.property("timer"),
  hours: function(){ 
    return this.get("time").getHours()
  }.property("time"),
  minutes: function(){ 
    return this.get("time").getMinutes()
  }.property("time"),
  seconds: function(){ 
    return this.get("time").getSeconds()
  }.property("time")
})

Sliders.slidersController.loadSliders();
