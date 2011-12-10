@Sliders.RulerView = SC.View.extend({
  classNames: ['timeline']
  
  timezoneBinding: 'parentView.content.timezone'
  
  templateName: 'sliders/ruler'
 
  hours: [0..23]
  
  click: (e) ->
    Element = e.target;
    CalculatedTotalOffsetLeft = 0
    while Element.offsetParent
      CalculatedTotalOffsetLeft += Element.offsetLeft
      Element = Element.offsetParent

    Sliders.RemoteTimeController.updateRemoteTime(e.pageX - CalculatedTotalOffsetLeft)

})
