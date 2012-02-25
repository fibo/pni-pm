// vim: ai et sw=4 ts=4 tw=80
//
// Folding
// vim: fdm=marker fmr=//[,//] fdc=4

/****

TODO scrivi qua come usi gli oggetti in JavaScript

    attributi privati, accessor, metodi delegati, ereditarietà, ecc

    spiega come usi il folding di vi, cioè come mai ci sono i commenti //[

    vedi se funziona che le cose che metto nel protoype sono protected

    //]

*****/

PNI = {}


PNI.CanvasItem = function(arg) { //[

    var canvas = arg.canvas
    var emptyHandle = function() {}

    this.getContext2d = canvas.getContext2d

    this.click = emptyHandle

    this.mousemove = emptyHandle

} //]


PNI.CanvasItem.Background = function(arg) { //[

    PNI.CanvasItem.call(this,arg)

    // This is a special CanvasItem, it draws nothing.
    this.draw = function() {}

    this.click = function(x,y) { console.log("background: "+x+","+y) }

    this.containsPoint = function() { return true }

} //]


PNI.CanvasItem.Rectangle = function(arg) { //[

    PNI.CanvasItem.call(this,arg)

    var centerX = arg.centerX
    var centerY = arg.centerY
    var height  = arg.height
    var width   = arg.width

    this.click = function(x,y) { console.log("rectangle: "+x+","+y) }
    this.mousemove = function(x,y) { console.log("rectangle: "+x+","+y) }

    this.getHeight = function() { return height }
    this.getWidth  = function() { return width }

    this.x1 = function() { return ( centerX - ( width / 2 ) ) }
    this.x2 = function() { return ( centerX + ( width / 2 ) ) }
    this.y1 = function() { return ( centerY - ( height / 2 ) ) }
    this.y2 = function() { return ( centerY + ( height / 2 ) ) }

    this.containsPoint = function(x,y) { //[

        // Check vertical bounds.
        if( ( x <= this.x1() ) || ( x >= this.x2() ) ) { return false }

        // Check horizontal bounds.
        if( ( y <= this.y1() ) || ( y >= this.y2() ) ) { return false }

        return true

    } //]

    this.draw = function() { //[

        var c = this.getContext2d()
        c.clearRect( 0, 0, this.getWidth(), this.getHeight() )
        c.save()
        c.strokeRect( this.x1(), this.y1(), this.getWidth(), this.getHeight() )
        c.restore()

    } //]

} //]


PNI.CanvasWidget = function(arg) { //[

    var canvas  = arg.canvas

    this.addItem = canvas.addItem

} //]


PNI.CanvasWidget.Node = function(arg) { //[

    PNI.CanvasWidget.call(this,arg)

    var inSlots  = []
    var outSlots = []
    var centerX = arg.centerX
    var centerY = arg.centerY
    var height  = arg.height || 40
    var width   = arg.width  || 100
    var box = this.addItem("rectangle",{centerX:centerX,centerY:centerY,height:height,width:width})

    var createInSlots = function(arg) { //[
        if( typeof arg == "undefined" ) { return }

        for ( var i = 0; i < arg.length; i++ ) {
            // arg[i] contains arguments for PNI.In constructor.
            arg[i].canvas = canvas

            // First inSlot is placed in north west point of node box.
            arg[i].centerX = box.x1()
            arg[i].centerY = box.y1()

            // inSlots after first one are placed along node box top border.
            if ( i > 0 ) {
                arg[i].centerX += i * ( box.getWidth() / ( arg.length - 1 ) )
            }

            // Create slot and add it to the inSlots.
            inSlots.push( new PNI.In(arg[i]) )
        }
    } //]

    var createOutSlots = function(arg) { //[

        if( typeof arg == "undefined" ) { return }

        for ( var i = 0; i < arg.length; i++ ) {
            // arg[i] contains arguments for PNI.Out constructor.
            arg[i].canvas = canvas

            // First outSlot is placed in south west point of node box.
            arg[i].centerX = box.x1()
            arg[i].centerY = box.y2()

            // outSlots after first one are placed along node box top border.
            if ( i > 0 ) {
                arg[i].centerX += i * ( box.getWidth() / ( arg.length - 1 ) )
            }

            // Create slot and add it to the outSlots.
            outSlots.push( new PNI.Out(arg[i]) )
        }

    } //]

    // So now a PNI.CanvasWidget.Node can create its slots, here we go.
    createInSlots(arg.inSlots)
    createOutSlots(arg.outSlots)

    this.setInSlots = function(arg) { //[

        // First of all reset inSlots.
        inSlots = []

        // Create inSlots.
        createInSlots(arg)

        // Finally draw all.
        this.draw()

    } //]

    this.setOutSlots = function(arg) { //[

        // First of all reset outSlots.
        outSlots = []

        // Create outSlots.
        createOutSlots(arg)

        // Finally draw all.
        this.draw()

    } //]

    this.draw = function() { //[

        box.draw()

        // Draw inSlots, if any.
        for ( var i = 0; i < inSlots.length; i++ ) {
            inSlots[i].draw()
        }

        // Draw outSlots, if any.
        for ( var i = 0; i < outSlots.length; i++ ) {
            outSlots[i].draw()
        }

    } //]

} //]


PNI.Slot = function (arg) { //[

    PNI.CanvasWidget.call(this,arg)

} //]


PNI.In = function(arg) { //[

    PNI.Slot.call(this,arg)

} //]


PNI.Out = function(arg) { //[

    PNI.Slot.call(this,arg)

    var centerX = arg.centerX
    var centerY = arg.centerY
    var height  = arg.height || 10
    var width   = arg.width || 10
    var box = canvas.add_rectangle({centerX:centerX,centerY:centerY,height:height,width:width})

    this.draw = function() {
        box.draw()
    }

} //]


PNI.CanvasViewPort = function(arg) { //[

    var canvas  = arg.canvas
    //TODO solo il CanvasViewPort puo fare il draw

} //]


PNI.Canvas = function(arg) { //[

    var _this = this

    var canvasId = arg.canvasId
    var canvas = document.getElementById(canvasId) 
    var background = new PNI.CanvasItem.Background({canvas:_this});
    var items = [background]
    var context2d = canvas.getContext('2d')

    this.getContext2d = function() { return context2d }
    this.getItems     = function() { return items }

    this.getHeight = function() { return canvas.height }
    this.getWidth  = function() { return canvas.width }

    this.addItem = function(itemType,arg) { //[

        arg.canvas = this

        var item
        if( itemType === "rectangle" ) {
            item = new PNI.CanvasItem.Rectangle(arg)
        }

        items.push(item)
        item.draw()

        return item

    } //]
    
    this.getItems = function() { return items }

    this.draw = function() { //[

        var c = this.getContext2d()
        var items = this.getItems();
        c.clearRect( 0, 0, this.getWidth(), this.getHeight() )
        c.save()
        //c.translate(0.5, 0.5)
        for( var i = 0; i < items.length; i++ ) {
            items[i].draw()
        }
        c.restore()

    } //]

    $('#'+canvasId).click( function(e) { //[

        var x = e.pageX - $('#'+canvasId).offset().left 
        var y = e.pageY - $('#'+canvasId).offset().top 

        var currentItem
        var items = _this.getItems()

        // Find currentItem, priority given by items index
        for( var i = 0; i < items.length; i++ ) {
            var item = items[i]
            if ( item.containsPoint(x,y) ) {
                currentItem = item
            }
        }

        currentItem.click(x,y)

    }) //]

    $('#'+canvasId).mousemove( function(e) { //[

        var x = e.pageX - $('#'+canvasId).offset().left 
        var y = e.pageY - $('#'+canvasId).offset().top 

        var currentItem
        var items = _this.getItems()

        // Find currentItem, priority given by items index
        for( var i = 0; i < items.length; i++ ) {
            var item = items[i]
            if ( item.containsPoint(x,y) ) {
                currentItem = item
            }
        }

        currentItem.mousemove(x,y)

    }) //]

} //]


PNI.Window = function(arg) { //[

    var canvas = new PNI.Canvas({canvasId:"pniview"})

    var canvasViewPort = new PNI.CanvasViewPort({canvas:canvas})

    canvas.addItem("rectangle",{centerX:100,centerY:100,height:10,width:10})
/*
    scenario.addNode({
        centerX:100,
        centerY:100,
        inSlots: [
            {in1:"foo"},
            {in2:"foo"},
            {in3:"foo"},
            {in4:"bar"}
        ],
        outSlots: []
    })
*/
} //]


