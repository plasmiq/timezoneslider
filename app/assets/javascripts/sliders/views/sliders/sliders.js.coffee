@Sliders.SlidersView = Ember.CollectionView.extend
  classNames: ['sliders']
   
  contentBinding: "Sliders.SlidersController.content" 

  itemViewClass: Sliders.SliderView

  emptyView: Ember.View.extend
    template: Ember.Handlebars.compile ""
  