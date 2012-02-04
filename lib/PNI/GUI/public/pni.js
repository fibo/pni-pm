/*
 *
 *
 *
 */
PNI = function (paper) {
this.paper=paper;
this.root = new PNI.Scenario(this);
};

/*
 *
 *
 *
 */
PNI.Scenario = function(pni) {
  this.pni = pni;
}

PNI.Scenario.prototype = {
  new_node: function () {
    var node = new PNI.Node(this.pni);
  }
}

/*
 * px: x coordinate of the top left corner
 * py: y coordinate of the top left corner
 *
 */
PNI.Node = function (pni) {
  this.pni = pni;
  this.px = 10;
  this.py = 10;
  this.height = 30;
  this.width = 80;
  var body=pni.paper.rect(this.px,this.py,this.width,this.height);
  var in1= new PNI.In(this.pni,this.px,this.py);
  /*
  var in2=pni.paper.rect(80,10,10,10);
  //var ins = new Array(in1,in2);

  in2.click(function () { //angle -= 90;
                    //img.stop().animate({transform: "r" + angle}, 1000, "<>");
                }).mouseover(function () {
                    in2.animate({fill: "#fc0"}, 300);
                }).mouseout(function () {
                    in2.stop().attr({fill: "#fff"});
                });
 */ 
  var fillColor=Raphael.color("gray");
  body.attr({fill:fillColor,cursor:"move"});

  var onmove=function (dx,dy) {
    body.attr({x:body.ox+dx,y:body.oy+dy});
    //in1.box.attr({x:in1.box.ox+dx,y:in1.box.oy+dy});
  } 

  var onstart = function () {
    // Storing original coordinates.
    body.ox=body.attr("x");
    body.oy=body.attr("y");
   
    //in1.box.ox=in1.attr("x");
    //in1.box.oy=in1.attr("y");
  }

var onend = function () {}

body.drag(onmove,onstart,onend);

}


/*
 *
 */
PNI.In = function(pni,px,py) {
  this.pni = pni;
  this.width = 10;
  this.height = 10;
  this.box = pni.paper.rect(px,py,this.width,this.height);
  var fillColor=Raphael.color("black");
  this.box.attr({fill:fillColor,cursor:"move"});

}
