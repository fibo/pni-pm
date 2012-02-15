
/*
******************************************************************************************
*
*/
PNI = {}

PNI.Window = function() {
    var that = this;
    var canvas = new PNI.Canvas({canvasId:"pniview"});

    var testNode = new PNI.Node({canvas:canvas,centerX:100,centerY:100});
    testNode.draw();
}

PNI.Canvas = function(arg) {
    var that = this;
    var canvasId = arg.canvasId;
    var canvas = document.getElementById(canvasId);
    var context2d = canvas.getContext('2d');
    // TODO vedi se ci sono due canvas se questa var rectangle e' condivisa
    var rectangles = [];

    $('#'+canvasId).click( function(e) {
        var x = e.pageX - $('#'+canvasId).offset().left; 
        var y = e.pageY - $('#'+canvasId).offset().top; 
        console.log('click: (x,y)=('+x+','+y+')');
        for ( var i = 0; i < rectangles.length; i++ ) {
            var item = rectangles[i]; 
            if ( item.containsPoint(x,y) ) {
                item.click(x,y);
            }
        }
    });

    this.add_rectangle = function(arg) {
        arg.context2d = context2d;
        var rectangle = new PNI.Rectangle(arg);
        rectangles.push(rectangle);
        return rectangle;
    }
}

PNI.Rectangle = function(arg) {
    var that = this;
    var centerX = arg.centerX;
    var centerY = arg.centerY;
    var height = arg.height;
    var width  = arg.width;
    
    var context2d = arg.context2d;

    this.draw = function() {
        context2d.strokeRect(that.x1(),that.y1(),width,height);
    }

    this.x1 = function() {
        return ( centerX - ( width / 2 ) );
    }

    this.x2 = function() {
        return ( centerX + ( width / 2 ) );
    }

    this.y1 = function() {
        return ( centerY - ( height / 2 ) );
    }

    this.y2 = function() {
        return ( centerY + ( height / 2 ) );
    }

    this.containsPoint = function(x,y) {
        // Check vertical bounds.
        if( ( x <= that.x1() ) || ( x >= that.x2() ) ) {
            return false;
        }

        // Check horizontal bounds.
        if( ( y <= that.y1() ) || ( y >= that.y2() ) ) {
            return false;
        }

        return true;
    }

    this.click = function(x,y) {
        console.log('rectangle click: (x,y)=('+x+','+y+')');
    }
}

PNI.Node = function(arg) {
    var centerX = arg.centerX;
    var centerY = arg.centerY;
    var height = arg.height || 100;
    var width  = arg.width || 100;

    var canvas = arg.canvas;

    var ins = [];
    var outs = [];

    ////////////////// faccio box public per fare una prova
    var box = this.box = canvas.add_rectangle({centerX:centerX,centerY:centerY,height:height,width:width});
    var ins0 = new PNI.In({node:this,position:0,canvas:canvas});
    this.draw = function() {
        box.draw();
        ins0.draw();
        // Draw inputs.
        //for( var i = 0; i <= ins.length; i++ ) {
        //    ins[i].draw();
        //}
        // Draw outputs.
        //for( var j = 0; j <= outs.length; j++ ) {
        //    outs[i].draw();
        //}
    }

}

PNI.In = function(arg) {
    var node = arg.node;
    var position = arg.position;
    var centerX = node.box.x1();
    var centerY = node.box.y1();
    var height = arg.height || 10;
    var width  = arg.width || 10;
    var canvas = arg.canvas;

    var box = canvas.add_rectangle({centerX:centerX,centerY:centerY,height:height,width:width});

    this.draw = function() {
    console.log(centerX);
        box.draw();
    }
}

PNI.Out = function(arg) {
    var node = arg.node;
    var position = arg.position;
    var centerX = node.box.x2();
    var centerY = node.box.y2();
    var height = arg.height || 10;
    var width  = arg.width || 10;
    var canvas = arg.canvas;

    var box = canvas.add_rectangle({centerX:centerX,centerY:centerY,height:height,width:width});

    this.draw = function() {
        box.draw();
    }
}

