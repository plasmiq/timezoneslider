@Sliders.Slider = SC.Record.extend({
  primaryKey: 'id',
  
  name: SC.Record.attr(String, {isRequired: true}),
  timezone: SC.Record.attr(String, {defaultValue: false}),
  
});

