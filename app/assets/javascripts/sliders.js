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
  templateName: 'sliders/new_slider',
  sliderBinding: 'parentView.content'
});

Sliders.SlidersView = SC.CollectionView.extend({
  contentBinding: "Sliders.slidersController",
});

Sliders.TimeZoneAutoComplete = SC.TextField.extend({
  
  didInsertElement: function() {
  
  }
});

Sliders.SliderView = SC.View.extend({
  templateName: 'sliders/slider',
  contentBinding: 'parentView.content',
  timezoneBinding: 'parentView.content.timezone',
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
  timezoneBinding: 'parentView.timezone',
  timerBinding: "Sliders.Timer.hasChanged",
  phase: 0,
  time: function() {
    var d = new Date();
    var utc = d.getTime() + (d.getTimezoneOffset() * 60000)
    return ( 
      new Date( utc + (this.get("timezone")*1000) + (this.get("phase")*1000) ) 
    );
  }.property("timer"),
  hours: function(){ 
    var h = this.get("time").getHours();
    if(h < 10) {
      h = '0'+h;    
    }
    return h;
  }.property("time"),
  minutes: function(){ 
    var m = this.get("time").getMinutes();
    if(m < 10) {
      m = '0'+m;    
    }
    return m;
  }.property("time"),
  seconds: function(){ 
    return this.get("time").getSeconds()
  }.property("time")
});

Sliders.CurrentTimeSliderView = Sliders.CurrentTimeView.extend({
  classNames: ['currentTimeSlider'],
  template: SC.Handlebars.compile("{{hours}}<br/>{{minutes}}<br/>{{seconds}}"),
  left: function() {
    this.$().animate("left","+1px");
  }.observes("timer"),
  style: function() {
    return "left: 200px"
  }.property(),
  attributeBindings: ['style']
});

Sliders.RemoteTimeSliderView = Sliders.CurrentTimeView.extend({
  classNames: ['remoteTimeSlider'],
  leftBinding: "Sliders.RemoteTimeController.left",
  style: function() {
    return "left: " + Sliders.RemoteTimeController.get("left") + "px";
  }.property("left"),
  phase: function() {
    return this.get("left");
  }.property("left"),
  attributeBindings: ['style'],
  template: SC.Handlebars.compile("{{left}}<br/>{{hours}}<br/>{{minutes}}<br/>{{seconds}}")
})


Sliders.RemoteTimeController = SC.Object.create({
  left: 0,
  res: 17,
  updateRemoteTime: function( position ){ 
    var l = parseInt(position / this.get('res')) * this.get('res');
    this.set("left", l);
  }
});

Sliders.RulerView = SC.View.extend({
  timezoneBinding: 'parentView.content.timezone',
  templateName: 'sliders/ruler',
  classNames: ['timeline'],
  time: function() {
    var d = new Date();
    var utc = d.getTime() + (d.getTimezoneOffset() * 60000)
    return (new Date(utc + (this.get("timezone")*1000)) );
  }.property(),
  hours: [],
  didInsertElement: function() {
    var hours = [];
    for(var i = 0; i < 24; i++) {
      hours[i] = i;
    }
    this.set("hours",hours)
  },
  click: function(e) {
    var Element = e.target ;
    var CalculatedTotalOffsetLeft = 0;
    while (Element.offsetParent)
    {
      CalculatedTotalOffsetLeft += Element.offsetLeft;
      Element = Element.offsetParent;
    }
    Sliders.RemoteTimeController.updateRemoteTime(e.pageX - CalculatedTotalOffsetLeft)
  }
})

Sliders.slidersController.loadSliders();
