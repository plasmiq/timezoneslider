@Sliders.HourView = SC.View.extend
  template: SC.Handlebars.compile("<tr><td>{{hour}}</td></tr>")
  
  tagName: "table"
  hourBinding: "parentView.content"
  
  style: (->
    if( @get("hour") == 0 )
      "background-color: black; color: white;"
  ).property("hour")
  
  attributeBindings: ['style']
