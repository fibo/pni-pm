// vim: ai et sw=4 ts=4 tw=80
//
// Folding
// TODO metti le conf per il folding solo documentate invitando ad aggiungerle nel vimrc
// vim: fdm=marker fmr=//[,//] 
// TODO create your own foldtext=v:folddashes.getline(v:foldstart)

/*******************************************************************************

*******************************************************************************/

PNI = {}

PNI.Window = function(arg) { //[
    var that = this;

    //[ private attributes
    var canvas = new PNI.Canvas({canvasId:"pniview"});
    var scenario = new PNI.Scenario({canvas:canvas});
    //]

} //]

PNI.Canvas = function(arg) {
    var that = this;

    // private attributes 
    var canvasId = arg.canvasId;
    var canvas = document.getElementById(canvasId);
    var context2d = canvas.getContext('2d');
    var rectangles = [];
    // 

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

    this.add_line = function(arg) {
        arg.context2d = context2d;
        var line = new PNI.Line(arg);
        lines.push(line);
        return line;
    }
}

PNI.Line = function(arg) {
    var that = this;

    // private attributes
    var context2d = arg.context2d;
    var startX    = arg.startX;
    var startY    = arg.startY;
    var endX      = arg.endX;
    var endY      = arg.endY;
    //
}

PNI.Rectangle = function(arg) {
    var that = this;

    // private attributes
    var context2d = arg.context2d; 
    var centerX   = arg.centerX;
    var centerY   = arg.centerY;
    var height    = arg.height;
    var width     = arg.width;
    //

    this.getHeight = function () { return height; }
    this.getWidth  = function () { return width; }

    this.draw = function () {
        context2d.strokeRect(that.x1(),that.y1(),width,height);
    }

    this.x1 = function () { return ( centerX - ( width / 2 ) ); }
    this.x2 = function () { return ( centerX + ( width / 2 ) ); }
    this.y1 = function () { return ( centerY - ( height / 2 ) ); }
    this.y2 = function () { return ( centerY + ( height / 2 ) ); }

    this.containsPoint = function(x,y) {
        // Check vertical bounds.
        if( ( x <= that.x1() ) || ( x >= that.x2() ) ) { return false; }

        // Check horizontal bounds.
        if( ( y <= that.y1() ) || ( y >= that.y2() ) ) { return false; }

        return true;
    }

    this.click = function(x,y) {
        console.log('rectangle click: (x,y)=('+x+','+y+')');
    }
}

PNI.Scenario = function(arg) {
    var that = this;

    /// private attributes
    var canvas  = arg.canvas;
    //.
}

PNI.Edge = function(arg) {
    var that = this;

    /// private attributes
    //.
}

PNI.Node = function(arg) {
    var that = this;

    /// private attributes
    var inSlots  = [];
    var outSlots = [];
    var canvas  = arg.canvas;
    var centerX = arg.centerX;
    var centerY = arg.centerY;
    var height  = arg.height || 40;
    var width   = arg.width  || 100;
    var box = canvas.add_rectangle({centerX:centerX,centerY:centerY,height:height,width:width});
    //.

    var createInSlots = function(arg) {
        if( typeof arg == "undefined" ) { return; }

        for ( var i = 0; i < arg.length; i++ ) {
            // arg[i] contains arguments for PNI.In constructor.
            arg[i].canvas = canvas;

            // First inSlot is placed in north west point of node box.
            arg[i].centerX = box.x1();
            arg[i].centerY = box.y1();

            // inSlots after first one are placed along node box top border.
            if ( i > 0 ) {
                arg[i].centerX += i * ( box.getWidth() / ( arg.length - 1 ) );
            }
            // Create slot and add it to the list as is: it will notify user changing its status
            // if some arg is wrong.
            inSlots.push( new PNI.In(arg[i]) );
        }
    }

    // So now a PNI.Node can create its inSlots, here we go.
    createInSlots(arg.inSlots);

    this.setInSlots = function(arg) {
        // First of all reset inSlots.
        inSlots = [];
        // Create inSlots.
        createInSlots(arg);
        // Finally draw all.
        that.draw();
    }

    var createOutSlots = function(arg) {
        if( typeof arg == "undefined" ) { return; }

        for ( var i = 0; i < arg.length; i++ ) {
            // arg[i] contains arguments for PNI.Out constructor.
            arg[i].canvas = canvas;

            // First outSlot is placed in south west point of node box.
            arg[i].centerX = box.x1();
            arg[i].centerY = box.y2();

            // outSlots after first one are placed along node box top border.
            if ( i > 0 ) {
                arg[i].centerX += i * ( box.getWidth() / ( arg.length - 1 ) );
            }
            // Create slot and add it to the list as is: it will notify user changing its status
            // if some arg is wrong.
            outSlots.push( new PNI.Out(arg[i]) );
        }
    }

    // So now a PNI.Node can create its outSlots, here we go.
    createOutSlots(arg.outSlots);

    this.setOutSlots = function(arg) {
        // First of all reset outSlots.
        outSlots = [];
        // Create outSlots.
        createOutSlots(arg);
        // Finally draw all.
        that.draw();
    }

    this.draw = function() {
        box.draw();
        // Draw inSlots, if any.
        for ( var i = 0; i < inSlots.length; i++ ) {
            inSlots[i].draw();
        }
        // Draw outSlots, if any.
        for ( var i = 0; i < outSlots.length; i++ ) {
            outSlots[i].draw();
        }
    }
}

PNI.In = function(arg) {
    var that = this;

    /// private attributes
    var centerX = arg.centerX;
    var centerY = arg.centerY;
    var height  = arg.height || 10;
    var width   = arg.width || 10;
    var canvas  = arg.canvas;
    var box = canvas.add_rectangle({centerX:centerX,centerY:centerY,height:height,width:width});
    //.

    this.draw = function() {
        box.draw();
    }
}

PNI.Out = function(arg) {
    var that = this;

    // private attributes {
    var canvas  = arg.canvas;
    var centerX = arg.centerX;
    var centerY = arg.centerY;
    var height  = arg.height || 10;
    var width   = arg.width || 10;
    var box = canvas.add_rectangle({centerX:centerX,centerY:centerY,height:height,width:width});

    this.draw = function() {
        box.draw();
    }
}

