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

// TODO vedi la doc di EventDispatcher, nativo in JavaScript
PNI.EventEmitter = function() { //[

    var actionsForEvent = {}

    this.on = function(eventType,action) { //[

        if(!actionsForEvent[eventType]) actionsForEvent[eventType] = []
        actionsForEvent[eventType].push(action)

    } //]

    this.emit = function(eventType,arg) { //[

        var actions = actionsForEvent[eventType] || []

        for (var i=0; i < actions.length; i++) { actions[i](arg) }

    } //]

} //]

PNI.EventEmitter.prototype.init = function () {}


PNI.CanvasItem = function() { //[

    PNI.EventEmitter.call(this)

} //]

PNI.CanvasItem.prototype = new PNI.EventEmitter()

PNI.CanvasItem.prototype.constructor = PNI.CanvasItem

PNI.CanvasItem.prototype.parent = PNI.EventEmitter.prototype

PNI.CanvasItem.prototype.containsPoint = function() { return false }

PNI.CanvasItem.prototype.draw = function() {}

PNI.CanvasItem.prototype.init = function(arg) { //[

    this.parent.init.call(this,arg)

    var canvas = arg.canvas

    this.getContext2d = canvas.getContext2d

} //]


PNI.CanvasItem.Background = function() { //[

    PNI.CanvasItem.call(this)

    // This is a special CanvasItem, it always contains a point.
    this.containsPoint = function() { return true }

    this.on("click",function(e){console.log(e)})

} //]

PNI.CanvasItem.Background.prototype = new PNI.CanvasItem()

PNI.CanvasItem.Background.prototype.constructor = PNI.CanvasItem.Background

PNI.CanvasItem.Background.prototype.parent = PNI.CanvasItem.prototype

PNI.CanvasItem.Rectangle = function() { //[

    PNI.CanvasItem.call(this)

// TODO metti metodo init come sopra

    var centerX = arg.centerX
    var centerY = arg.centerY
    var height  = arg.height
    var width   = arg.width

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

    this.addItem = function(itemType,arg) { return canvas.addItem(itemType,arg) }

} //]


PNI.CanvasWidget.Node = function(arg) { //[

    PNI.CanvasWidget.call(this,arg)

    var inSlots  = []
    var outSlots = []
    var canvas  = arg.canvas
    var centerX = arg.centerX
    var centerY = arg.centerY
    var height  = arg.height || 40
    var width   = arg.width  || 100
    var box = this.addItem("rectangle",{centerX:centerX,centerY:centerY,height:height,width:width})

    var createInSlots = function(arg) { //[

        if ( typeof arg == "undefined" ) { return }

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

// TODO fai che lo slot ha due box, uno interno e uno esterno cosi posso fare l'
// evento enter e exit usando il mousemove

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

    var canvasId = arg.canvasId
    var canvas = document.getElementById(canvasId) 
    var $canvas = $('#'+canvasId)
    
    this.getHeight = function() { return canvas.height }
    this.getWidth  = function() { return canvas.width }

    var context2d = canvas.getContext('2d')
    this.getContext2d = function() { return context2d }

    this.init = function(arg) {
        var background = new PNI.CanvasItem.Background()
        background.init({canvas:this})
        this.pushItem(background)
    }

    var items = []
    this.getItems = function() { return items }
    this.pushItem = function(item) { items.push(item) }

/*
    this.draw = function() { //[

        var c = this.getContext2d()
        var items = this.getItems()
        c.clearRect( 0, 0, this.getWidth(), this.getHeight() )
        c.save()
        //c.translate(0.5, 0.5)
        for( var i = 0; i < items.length; i++ ) {
            items[i].draw()
        }
        c.restore()

    } //]
*/

    var _this = this

    $canvas.click( function(e) { //[

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

        currentItem.emit("click",{x:x,y:y})

    }) //]

    $canvas.mousemove( function(e) { //[

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

        currentItem.emit("mousemove",{x:x,y:y})

    }) //]

} //]

PNI.Canvas.prototype.addItem = function(itemType,arg) { //[

    var item
    arg.canvas = this

    if( itemType === "rectangle" ) {
        item = new PNI.CanvasItem.Rectangle()
        item.init(arg)
    }

    this.pushItem(item)
    item.draw()

    return item

} //]
    

PNI.Window = function(arg) { //[

    var canvas = new PNI.Canvas({canvasId:"pniview"})
    canvas.init({canvasId:"pniview"})

    //var canvasViewPort = new PNI.CanvasViewPort()
    //canvasViewPort.init({canvas:canvas})


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


