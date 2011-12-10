@Sliders.LocalTimeController = SC.Object.create({
  getHoursShift: (shift) ->
    remote = shift
    local = (new Date()).getTimezoneOffset() * (-60) 
    ( remote - local ) / 3600
})

