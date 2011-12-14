@Sliders.RemoteTimeController = SC.Object.create
  
  updateRemoteTime: ( position ) -> 
    m = position * 60 * 24
    @set("minutesToday", m)
    
  minutesToday: null
    
  

