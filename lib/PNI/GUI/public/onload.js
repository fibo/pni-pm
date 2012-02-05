
window.onload = function () {

  var paper = Raphael("paper","100%","100%");

  var pni = new PNI(paper);
  var node = new PNI.View.Node(pni.view,50,100);
  //pni.view.rectangle(10,10,20,20);
}
