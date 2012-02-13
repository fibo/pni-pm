
/*
 **************************************************************************
 *
 */
PNI = {}

PNI.Window = function(){
  this.canvas = new PNI.Canvas({canvasId:"pniview"});

  this.canvas.add_rectangle({x:100,y:100,width:20,height:20});
}

PNI.Canvas = function(arg){
  var canvasId = arg.canvasId;
  var canvas = document.getElementById(canvasId);
  this.context2d = canvas.getContext('2d');
  // TODO vedi se ci sono due canvas se questa var rectangle e' condivisa
  var rectangles = [];

  $('#'+canvasId).click(function(e){
    var x = e.pageX - $('#'+canvasId).offset().left; 
    var y = e.pageY - $('#'+canvasId).offset().top; 
    console.log('click: (x,y)=('+x+','+y+')');
    for( var i = 0; i < rectangles.length; i++ ){
      var item = rectangles[i]; 
      if( item.containsPoint(x,y) ){
        item.click(x,y);
      }
    }
  });

  this.add_rectangle = function(arg){
    var rectangle = new PNI.Rectangle(arg);
    rectangle.draw(this.context2d);
    rectangles.push(rectangle);
  }
}

PNI.Rectangle = function(arg){
  this.x=arg.x;
  this.y=arg.y;
  this.height=arg.height;
  this.width=arg.width;

  this.draw=function(context2d){
    context2d.strokeRect(this.x,this.y,this.width,this.height);
  }

  this.containsPoint = function(x,y){
    // Check vertical bounds.
    if( ( x <= this.x ) || ( x >= ( this.x + this.width ) ) )
      return false;

    // Check horizontal bounds.
    if( ( y <= this.y ) || ( y >= ( this.y + this.width ) ) )
      return false;

    return true;
  }

  this.click = function(x,y) {
    console.log('rectangle click: (x,y)=('+x+','+y+')');
  }
}

