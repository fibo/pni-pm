/*
 *
 **************************************************************************
 *
 * Every class is documented with a comment header with
 *
 * Constructor
 * arguments list required by constructor
 * every item in the arguments list is an attribute of the class
 * additional attributes list
 * 
 */

/*
 *
 *
 *
 */
/*
 **************************************************************************
 * Constructor
 * p: Raphael paper
 **************************************************************************
 *
 *
 **************************************************************************
 */
PNI = function(p) { 
  this.p = p;
  this.view = new PNI.View.Raphael(p);
}
/*
 **************************************************************************
 *
 */
PNI.View = {}
/*
 **************************************************************************
 * Constructor
 * p: Raphael paper
 **************************************************************************
 *
 */
PNI.View.Raphael = function(p) {
  this.p = p;
  this.slotHalfLength = 5;
  this.rectangle = function(x,y,w,h) {
    return p.rect(x,y,w,h);
  }
}
/*
 *
 *
 * v: PNI.View
 *
 */
PNI.View.Node = function(view,x,y,w,h) {
  this.view = view;
  this.x = x;
  this.y = y;
  this.w = w || 80;
  this.h = h || 20;
  this.ins = new Array();
  this.outs = new Array();
  this.outs.push("out2");
  this.ins.push("in2");
  this.ins.push("in2");
  this.box = this.view.rectangle(this.x,this.y,this.w,this.h);
  for( var i = 0; i < this.ins.length; i++ ){
    new PNI.View.Input(this,i);
  }
  for( var j = 0; j < this.ins.length; j++ ){
    new PNI.View.Output(this,j);
  }
}

PNI.View.Input = function(node,position) {
  this.node = node;
  var x = this.node.x;
  var y = this.node.y;
  var l = this.node.view.slotHalfLength * 2;
  if( this.node.ins.length > 1 ) {
    x = x + ( this.node.w / ( this.node.ins.length - 1 ) ) * position;
  }
  this.box = this.node.view.rectangle(x,y,l,l);
}

PNI.View.Output = function(node,position) {
  this.node = node;
  var x = this.node.x;
  var y = this.node.y + this.node.w;
  var l = this.node.view.slotHalfLength * 2;
  if( this.node.outs.length > 1 ) {
    x = x + ( this.node.w / ( this.node.ins.length - 1 ) ) * position;
  }
  this.box = this.node.view.rectangle(x,y,l,l);
}

