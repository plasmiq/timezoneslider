JQueryUI = SC.Object.create();

JQueryUI.Widget = SC.Mixin.create({
  uiChildElement: function() {
    if (this.get('uiChildTag')) {
      return this.$( this.get('uiChildTag') );
    } else {
      return this.$();
    }
  },
  
  didInsertElement: function() {
    this._super();

    SC.run.schedule('render', this, function() {
      var options = this._gatherOptions();
      this._gatherEvents(options);

      var ui = new jQuery.ui[this.get('uiType')](options, this.uiChildElement());

      this.set('ui', ui);
    });
  },

  _gatherEvents: function(options) {
    var uiEvents = this.get('uiEvents') || [], self = this;

    uiEvents.forEach(function(event) {
      var callback = self[event];

      if (callback) {
        options[event] = function(event, ui) { callback.call(self, event, ui); };
      }
    });
  },

  willDestroyElement: function() {
    var ui = this.get('ui');
    if (ui) {
      var observers = this._observers;
      for (var prop in observers) {
        if (observers.hasOwnProperty(prop)) {
          this.removeObserver(prop, observers[prop]);
        }
      }
      ui._destroy();
    }
  },

  _gatherOptions: function() {
    var uiOptions = this.get('uiOptions'), options = {};

    uiOptions.forEach(function(key) {
      options[key] = this.get(key);

      var observer = function() {
        var value = this.get(key);
        this.get('ui')._setOption(key, value);
      };

      this.addObserver(key, observer);

      this._observers = this._observers || {};
      this._observers[key] = observer;
    }, this);
    return options;
  }
});

JQueryUI.TextField = SC.TextField.extend(JQueryUI.Widget, {uiChildTag: 'input'});
