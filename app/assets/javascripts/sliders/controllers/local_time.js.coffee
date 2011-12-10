@Sliders.LocalTimeController = SC.Object.create({
  getHoursShift: (shift) ->
    remote = shift
    local = (new Date()).getTimezoneOffset() * (-60) 
    ( local - remote ) / 3600
})

