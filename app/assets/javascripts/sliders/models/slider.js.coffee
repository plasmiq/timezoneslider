@Sliders.Slider = SC.Record.extend({
  primaryKey: 'id',
  
  name: SC.Record.attr(String, {isRequired: true}),
  location: SC.Record.attr(String, {defaultValue: false}),
  timezone: SC.Record.attr(Number, {defaultValue: false}),
  
});

