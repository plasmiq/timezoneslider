@Sliders.TimerController = SC.Object.create({
  hasChanged: 0
  startTicking: ->
    Sliders.TimerController.set("hasChanged", Sliders.TimerController.get("hasChanged") + 1 );
    setTimeout(Sliders.TimerController.startTicking,1000);
});
