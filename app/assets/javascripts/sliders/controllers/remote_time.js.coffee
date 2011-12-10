@Sliders.RemoteTimeController = SC.Object.create({
  left: 0
  res: 17
  
  updateRemoteTime: ( position ) -> 
    l = parseInt(position / this.get('res')) * this.get('res')
    this.set("left", l)
})

