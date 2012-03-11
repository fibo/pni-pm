// vim: ai et sw=4 ts=4 tw=80
// vim: fdm=marker fmr=//[,//] fdc=4

/********************************************************************************


 *******************************************************************************/

var $j= jQuery.noConflict();

PNI = { //[
    extend: function(sub, sup) {
        for (var key in sup.prototype) {
            if (sup.prototype.hasOwnProperty(key)) { 
                sub.prototype[key] = sup.prototype[key]; 
            }
        }
    },
    theme: {}
};
//]
PNI.Emitter = function() { //[ 
    this.handler = {
        start: {}
    };
    this.state = {
        error:-1,
        start:0
    };
};
PNI.Emitter.prototype = {
    on: function(statusType,eventType,handler) { 
        this.handler[statusType][eventType] = handler;
    }, 
    emit: function(eventType,arg) {
        var currentState="start";
        var func = this.handler[currentState][eventType];
        if (typeof func==="function") { func(arg); }
    }
};
//]
PNI.CanvasItem = function(arg) { //[
    this.canvas = arg.canvas;
    PNI.Emitter.apply(this,arg);
};
PNI.CanvasItem.prototype = {
    draw: function(c){}
};
PNI.extend(PNI.CanvasItem,PNI.Emitter);
//]
PNI.CanvasItem.Background = function(arg) { //[
    PNI.CanvasItem.apply(this,arg); 
}; 
PNI.CanvasItem.Background.prototype = {
    containsPoint: function(x,y) { return true; },
    draw: function(c) {}
};
PNI.extend(PNI.CanvasItem.Background,PNI.CanvasItem);
//]

/*

PNI.CanvasItem.Line = function() { PNI.CanvasItem.call(this) } 

PNI.CanvasItem.Line.prototype = new PNI.CanvasItem.Line()

PNI.CanvasItem.Line.prototype.constructor = PNI.CanvasItem.Line

PNI.CanvasItem.Line.prototype.init = function(arg) { //[

    var startX = arg.startX
    var startY = arg.startY
    var endX = arg.endX
    var endY = arg.endY

    this.getStartX = function() { return startX }
    this.getStartY = function() { return startY }
    this.getEndX   = function() { return endX }
    this.getEndY   = function() { return endY }

    this.translateStart = function(dx,dy) { //[

        startX = startX + dx
        startY = startY + dy

    } //]

    this.translateEnd = function(dx,dy) { //[

        endX = endX + dx
        endY = endY + dy

    } //]

    this.on("click",function() {console.log("line")})

} //]

PNI.CanvasItem.Line.prototype.containsPoint = function(x,y) { //[

//  Using matrix Algebra to Calculate if point x,y is contained in line.
//
//  | startX startY 1 |
//  | endX   endY   1 | = startX * (endY - y) - startY * (endX - x) + 1 (endX *  y) - (x * EndY)
//  | x      y      1 |
//

    var det = this.getStartX() * (this.getEndY()-y) - this.getStartY() * (this.getEndX()-x) + this.getEndX()*y - x*this.getEndY()

    if(det==0) { return true } else { return false }

} //]

PNI.CanvasItem.Line.prototype.draw = function(c) { //[

    c.beginPath()
    c.moveTo(this.getStartX(),this.getStartY())
    c.lineTo(this.getEndX(),this.getEndY())
    c.stroke()

}//]

//]


// PNI.CanvasItem.Rectangle //[

PNI.CanvasItem.Rectangle = function() { PNI.CanvasItem.call(this) }

PNI.CanvasItem.Rectangle.prototype = new PNI.CanvasItem.Rectangle()

PNI.CanvasItem.Rectangle.prototype.constructor = PNI.CanvasItem.Rectangle

PNI.CanvasItem.Rectangle.prototype.init = function(arg) { //[

    var centerX = arg.centerX
    var centerY = arg.centerY
    var height  = arg.height
    var width   = arg.width

    this.getHeight = function() { return height }
    this.getWidth  = function() { return width }

    this.translate = function(dx,dy) { //[

        centerX = centerX + dx
        centerY = centerY + dy

    } //]

    this.x1 = function() { return ( centerX - ( width / 2 ) ) }
    this.x2 = function() { return ( centerX + ( width / 2 ) ) }
    this.y1 = function() { return ( centerY - ( height / 2 ) ) }
    this.y2 = function() { return ( centerY + ( height / 2 ) ) }

} //]

PNI.CanvasItem.Rectangle.prototype.containsPoint = function(x,y) { //[

    // Check vertical bounds.
    if( ( x <= this.x1() ) || ( x >= this.x2() ) ) { return false }

    // Check horizontal bounds.
    if( ( y <= this.y1() ) || ( y >= this.y2() ) ) { return false }

    return true

} //]

PNI.CanvasItem.Rectangle.prototype.draw = function(c) { //[

    //c.clearRect( 0, 0, this.getWidth(), this.getHeight() )
    //c.save()
    c.strokeRect( this.x1(), this.y1(), this.getWidth(), this.getHeight() )
    //c.restore()

} //]

//]


// PNI.CanvasWidget

PNI.CanvasWidget = { }


// PNI.CanvasWidget.Node //[

PNI.CanvasWidget.Node = function() {}

PNI.CanvasWidget.Node.prototype.init = function(arg) { //[

    var canvas = arg.canvas
    var centerX = arg.centerX
    var centerY = arg.centerY
    var height  = 50
    var width   = 100

    var inSlots  = []
    if(!arg.inSlots) arg.inSlots = []
    var outSlots = []
    if(!arg.outSlots) arg.outSlots = []

    var box = canvas.addItem("rectangle")
    box.init({centerX:centerX,centerY:centerY,height:height,width:width})

    // Init inSlots 
    for ( var i = 0; i < arg.inSlots.length; i++ ) { //[

        var my = arg.inSlots[i]

        // First inSlot is placed in north west point of node box.
        var centerX = box.x1()
        var centerY = box.y1()

        // inSlots after first one are placed along node box top border.
        if ( i > 0 ) {
            centerX += i * ( box.getWidth() / ( arg.inSlots.length - 1 ) )
        }

        // Create slot and add it to the inSlots.
        var slot = new PNI.Slot()
        slot.init({name:my.name,data:my.data,canvas:canvas,centerX:centerX,centerY:centerY})
        inSlots.push( slot )

    } //]

    // Init outSlots 
    for ( var i = 0; i < arg.outSlots.length; i++ ) { //[ outslots

        var my = arg.outSlots[i]

        // First outSlot is placed in south west point of node box.
        var centerX = box.x1()
        var centerY = box.y2()

        // outSlots after first one are placed along node box top border.
        if ( i > 0 ) {
            centerX += i * ( box.getWidth() / ( arg.outSlots.length - 1 ) )
        }

        // Create slot and add it to the outSlots.
        var slot = new PNI.Slot()
        slot.init({name:my.name,data:my.data,canvas:canvas,centerX:centerX,centerY:centerY})
        outSlots.push( slot )

    } //]

    var translate = function(dx,dy) { //[

        box.translate(dx,dy)

        for ( var i = 0; i < inSlots.length; i++ ) { inSlots[i].translate(dx,dy) }

        for ( var i = 0; i < outSlots.length; i++ ) { outSlots[i].translate(dx,dy) }

    } //]

    var drag
    var lastMouseX
    var lastMouseY

    box.on("mousedown",function(e) { //[

        drag=true    

        lastMouseX = e.x
        lastMouseY = e.y

    }) //]

    box.on("mousemove",function(e) {

        if(drag) {

            var dx = e.x - lastMouseX
            var dy = e.y - lastMouseY

            translate(dx,dy)

            lastMouseX = e.x
            lastMouseY = e.y

        }

    })

    box.on("mouseup",function(e) { drag=false })

} //]

//]


PNI.Slot = function() { }

PNI.Slot.prototype.init = function(arg) { //[

    var canvas = arg.canvas
    var centerX = arg.centerX
    var centerY = arg.centerY
    var data = arg.data || {}
    var name = arg.name || "slot"

    var l1 = 16
    var l2 = l1 - 6

    var enter = false

    // box2 is inside box1
    var box1 = canvas.addItem("rectangle")
    var box2 = canvas.addItem("rectangle")
    box1.init({centerX:centerX,centerY:centerY,height:l1,width:l1})
    box2.init({centerX:centerX,centerY:centerY,height:l2,width:l2})

    this.translate = function(dx,dy) { //[

        centerX = centerX + dx
        centerY = centerY + dy

        box1.translate(dx,dy)
        box2.translate(dx,dy)

    } //]

    box2.on("click",function(e) {
        console.log(name)
        console.log(data)
    } )

    box1.on("mousemove",function(e) {
        enter = false
    } )

    box2.on("mousemove",function(e) {
        enter = true
    } )

} //]


// PNI.Canvas //[

PNI.Canvas = function() {}

PNI.Canvas.prototype = new Object()

PNI.Canvas.prototype.constructor = PNI.Canvas

PNI.Canvas.prototype.init = function(canvasId) { //[

    // TODO dovrei usare o $canvas o canvas, il primo e' di JQuery ed e' un
    // array di tutti gli elementi del DOM con id canvasId
    //var canvasId = canvasId
    var canvas = document.getElementById(canvasId) 
    var $canvas = $('#'+canvasId)

    var c = canvas.getContext('2d')

    var background = new PNI.CanvasItem.Background()
    background.init()

    var items = [background]

    this.addItem = function(itemType) { //[

        var item

        if( itemType === "rectangle" ) {
            item = new PNI.CanvasItem.Rectangle()
        }
        if( itemType === "line" ) {
            item = new PNI.CanvasItem.Line()
        }

        //        item.init(arg)
        items.push(item)
        //item.draw()

        return item

    } //]

    var draw = function() { //[

        c.save()
        c.translate(0.5,0.5)
        c.clearRect( 0, 0, canvas.width, canvas.height )

        for ( var i = 0; i < items.length; i++ ) { items[i].draw(c) }

        c.restore()

    } //]

    $canvas.click( function(e) { //[

        var x = e.pageX - $canvas.offset().left 
        var y = e.pageY - $canvas.offset().top 

        var currentItem

        // Find currentItem, priority given by items index .
        for ( var i = 0; i < items.length; i++ ) {
            var item = items[i]
            if ( item.containsPoint(x,y) ) {
                currentItem = item
            }
        }

        // At least background item will be currentItem .
        currentItem.emit("click",{x:x,y:y})

    }) //]

    $canvas.mousedown( function(e) { //[

        var x = e.pageX - $canvas.offset().left 
        var y = e.pageY - $canvas.offset().top 

        var currentItem

        // Find currentItem, priority given by items index .
        for ( var i = 0; i < items.length; i++ ) {
            var item = items[i]
            if ( item.containsPoint(x,y) ) {
                currentItem = item
            }
        }

        // At least background item will be currentItem.
        currentItem.emit("mousedown",{x:x,y:y})
        draw(c)

    }) //]

    $canvas.mousemove( function(e) { //[

        var x = e.pageX - $canvas.offset().left 
        var y = e.pageY - $canvas.offset().top 

        var currentItem

        // Find currentItem, priority given by items index .
        for ( var i = 0; i < items.length; i++ ) {
            var item = items[i]
            if ( item.containsPoint(x,y) ) {
                currentItem = item
            }
        }

        // At least background item will be currentItem.
        currentItem.emit("mousemove",{x:x,y:y})
        draw(c)

    }) //]

    $canvas.mouseup( function(e) { //[

        var x = e.pageX - $canvas.offset().left 
        var y = e.pageY - $canvas.offset().top 

        var currentItem

        // Find currentItem, priority given by items index .
        for ( var i = 0; i < items.length; i++ ) {
            var item = items[i]
            if ( item.containsPoint(x,y) ) {
                currentItem = item
            }
        }

        // At least background item will be currentItem.
        currentItem.emit("mouseup",{x:x,y:y})
        draw(c)

    }) //]

} //]

//]

PNI.Window = function(arg) { //[

    var canvas = new PNI.Canvas()
    canvas.init("pniview")

    var lineJSON = {canvas:canvas,startX:100,startY:100,endX:150,endY:100}
    var line = canvas.addItem("line")
    line.init(lineJSON)

    var inSlotsJSON = [{name:"in1"},{name:"in2",data:["ok","ok2"]},{},{},{}]
    var outSlotsJSON = [{name:"pippo",data:{foo:"bar"}},{},{}]
    var nodeJSON = {
        canvas:canvas,
        centerX:100,
        centerY:100,
        inSlots:inSlotsJSON,
        outSlots:outSlotsJSON
    }
    var n = new PNI.CanvasWidget.Node()
    n.init(nodeJSON)
    //n.init({canvas:canvas,centerX:100,centerY:100,inSlots:{},outSlots:{}})

} //]

PNI.Window.prototype = new Object()

PNI.Window.prototype.constructor = PNI.Window

*/


