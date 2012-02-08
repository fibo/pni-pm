
/*
 **************************************************************************
 *
 */
PNI = {}

PNI.View = function(){
  var canvasId = "pniview";
  var canvas = document.getElementById(canvasId);
  var context2d = canvas.getContext('2d');

  var scenario = new PNI.Scenario(context2d);
  $('#'+canvasId).click(function(e){
    var x = e.pageX - $('#'+canvasId).offset().left; 
    var y = e.pageY - $('#'+canvasId).offset().top; 
    scenario.addNode(x,y);
  });

}
PNI.View.prototype.constructor = PNI.View;

PNI.Scenario = function(context2d) {
  this.addNode = function(x,y) {
    context2d.fillStyle = "rgb(150,29,28)";
    context2d.fillRect(x,y,20,20);
  }
}
PNI.Scenario.prototype.constructor = PNI.Scenario;

PNI.Node = function() {
}
PNI.Node.prototype.constructor=PNI.Node;

PNI.In = function(node,position) {
}
PNI.In.prototype.constructor = PNI.In;

PNI.Out = function(node,position) {
}
PNI.Out.prototype.constructor = PNI.Out;

