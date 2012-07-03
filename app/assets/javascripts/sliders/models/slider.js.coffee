@Sliders.Slider = Ember.Object.extend({
  id: (->
  	return this.get("name")+this.get("timezone")
  ).property()
});

