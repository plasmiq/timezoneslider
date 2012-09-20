@Sliders.HourView = Ember.View.extend
  template: Ember.Handlebars.compile("<tr><td>{{content}}</td></tr>")
  
  tagName: "table"
  
  style: (->
    if( @get("content") == 0 )
      "background-color: black; color: white;"
  ).property("content")
  
  attributeBindings: ['style']
