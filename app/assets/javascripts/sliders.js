Sliders = SC.Application.create({
  store: SC.Store.create({commitRecordsAutomatically: true}).from('SB.RestDataSource')
});

Sliders.Slider = SC.Record.extend({
  primaryKey: 'id',
  

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

Sliders.SlidersView = SC.CollectionView.extend({
  contentBinding: "Sliders.slidersController",
});

Sliders.TimeZoneAutoComplete = SC.TextField.extend({
  
  didInsertElement: function() {
  
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

Sliders.slidersController.loadSliders();
