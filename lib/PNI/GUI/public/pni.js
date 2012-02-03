PNI={};

PNI.Node = function (paper) {

  var body=paper.rect(20,20,80,30);
  var in1=paper.rect(20,10,10,10);
  var in2=paper.rect(80,10,10,10);
  //var ins = new Array(in1,in2);

  in2.click(function () { //angle -= 90;
                    //img.stop().animate({transform: "r" + angle}, 1000, "<>");
                }).mouseover(function () {
                    in2.animate({fill: "#fc0"}, 300);
                }).mouseout(function () {
                    in2.stop().attr({fill: "#fff"});
                });
  
  var fillColor=Raphael.color("black");
  var slotFillColor=Raphael.color("white");
  body.attr({fill:fillColor,cursor:"move"});
  in1.attr({fill:fillColor,cursor:"move"});
  /*for(i in ins) {
    i.attr({fill:slotFillColor});
  }*/

  var onmove=function (dx,dy) {
    body.attr({x:body.ox+dx,y:body.oy+dy});
    in1.attr({x:in1.ox+dx,y:in1.oy+dy});
  } 

  var onstart = function () {
    // Storing original coordinates.
    body.ox=body.attr("x");
    body.oy=body.attr("y");
   
    in1.ox=in1.attr("x");
    in1.oy=in1.attr("y");
  }

var onend = function () {}

body.drag(onmove,onstart,onend);
in1.drag(onmove,onstart,onend);

}
