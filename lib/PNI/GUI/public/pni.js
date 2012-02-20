// vim: ai et sw=4 ts=4 tw=80
//
// Folding
// vim: fdm=marker fmr=//[,//] fdc=4

PNI = { 
    nextId:0
}

PNI.Elem = function () { //[
    PNI.nextId = PNI.nextId + 1
    this.id = PNI.nextId
} //]

/*
PNI.Line = function(arg) { //[

    //[ private attributes
    var context2d = arg.context2d
    var startX    = arg.startX
    var startY    = arg.startY
    var endX      = arg.endX
    var endY      = arg.endY
    //]
} //]
*/

PNI.CanvasItem = function(arg) { //[
    var canvas = arg.canvas

    this.getContext2d = function() { return canvas.getContext2d() }

    this.click = function(x,y) { //[
        console.log('click: (x,y)=('+x+','+y+')')
    } //]
    this.mousemove = function(x,y) { //[
        //console.log('mousemove: (x,y)=('+x+','+y+')')
    } //]
} //]

PNI.Rectangle = function(arg) { //[

    PNI.CanvasItem.call(this,arg)

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

    this.click     = function() {}
    //this.mousemove = function() {}

} //]

/*
PNI.Edge = function(arg) { //[

    PNI.Elem.call(this)

    //[ private attributes
    //]

} //]

PNI.Node = function(arg) { //[

    PNI.Elem.call(this)
    var that = this

    //[ private attributes
    var inSlots  = []
    var outSlots = []
    var canvas  = arg.canvas
    var centerX = arg.centerX
    var centerY = arg.centerY
    var height  = arg.height || 40
    var width   = arg.width  || 100
    var box = canvas.add_rectangle({centerX:centerX,centerY:centerY,height:height,width:width})
    //]

    //[ private methods
    
    var createInSlots = function(arg) { //[
        if( typeof arg == "undefined" ) { return }

        for ( var i = 0 i < arg.length i++ ) {
            // arg[i] contains arguments for PNI.In constructor.
            arg[i].canvas = canvas

            // First inSlot is placed in north west point of node box.
            arg[i].centerX = box.x1()
            arg[i].centerY = box.y1()

            // inSlots after first one are placed along node box top border.
            if ( i > 0 ) {
                arg[i].centerX += i * ( box.getWidth() / ( arg.length - 1 ) )
            }
            // Create slot and add it to the list as is: it will notify user changing its status
            // if some arg is wrong.
            inSlots.push( new PNI.In(arg[i]) )
        }
    } //]

    var createOutSlots = function(arg) { //[
        if( typeof arg == "undefined" ) { return }

        for ( var i = 0 i < arg.length i++ ) {
            // arg[i] contains arguments for PNI.Out constructor.
            arg[i].canvas = canvas

            // First outSlot is placed in south west point of node box.
            arg[i].centerX = box.x1()
            arg[i].centerY = box.y2()

            // outSlots after first one are placed along node box top border.
            if ( i > 0 ) {
                arg[i].centerX += i * ( box.getWidth() / ( arg.length - 1 ) )
            }
            // Create slot and add it to the list as is: it will notify user changing its status
            // if some arg is wrong.
            outSlots.push( new PNI.Out(arg[i]) )
        }
    } //]

    //]

    // So now a PNI.Node can create its lots, here we go.
    createInSlots(arg.inSlots)
    createOutSlots(arg.outSlots)

    this.setInSlots = function(arg) { //[
        // First of all reset inSlots.
        inSlots = []
        // Create inSlots.
        createInSlots(arg)
        // Finally draw all.
        that.draw()
    } //]

    this.setOutSlots = function(arg) { //[
        // First of all reset outSlots.
        outSlots = []
        // Create outSlots.
        createOutSlots(arg)
        // Finally draw all.
        that.draw()
    } //]

    this.draw = function() {
        box.draw()
        // Draw inSlots, if any.
        for ( var i = 0 i < inSlots.length i++ ) {
            inSlots[i].draw()
        }
        // Draw outSlots, if any.
        for ( var i = 0 i < outSlots.length i++ ) {
            outSlots[i].draw()
        }
    }
} //]

PNI.Scenario = function(arg) { //[
    this.canvas  = arg.canvas
    this.nodes = arg.nodes || []
    this.edges = arg.edges || []

this.addEdge = function(arg) { //[
    var edge = new PNI.edge(arg)
    this.edges.push(edge)
    return edge
} //]
this.addNode = function(arg) { //[
    var node = new PNI.Node(arg)
    this.nodes.push(node)
    return node
} //]

} //]

PNI.Slot = function (arg) {

    var centerX = arg.centerX
    var centerY = arg.centerY
    var height  = arg.height || 10
    var width   = arg.width || 10

}

PNI.In = function(arg) { //[

    PNI.Slot.call(this,arg)

    //[ private attributes
    var centerX = arg.centerX
    var centerY = arg.centerY
    var height  = arg.height || 10
    var width   = arg.width || 10
    var canvas  = arg.canvas
    var box = canvas.add_rectangle({centerX:centerX,centerY:centerY,height:height,width:width})
    //]

    this.draw = function() {
        box.draw()
    }
} //]

PNI.Out = function(arg) { //[

    PNI.Slot.call(this,arg)

    //[ private attributes {
    var canvas  = arg.canvas
    var centerX = arg.centerX
    var centerY = arg.centerY
    var height  = arg.height || 10
    var width   = arg.width || 10
    var box = canvas.add_rectangle({centerX:centerX,centerY:centerY,height:height,width:width})
    //]

    this.draw = function() {
        box.draw()
    }
} //]
*/

PNI.Canvas = function(arg) { //[

    var that = this

    var canvasId = arg.canvasId
    var canvas = document.getElementById(canvasId) 
    //console.log(canvas)
    var items = []
    var context2d = canvas.getContext('2d')

    this.addItem = function(item) { items.push(item) }

    this.getContext2d = function() { return context2d }
    this.getItems     = function() { return items }

    this.getHeight = function() { return canvas.height }
    this.getWidth  = function() { return canvas.width }

    this.addRectangle = function(arg) { //[
        arg.canvas = this
        var rectangle = new PNI.Rectangle(arg)
        this.addItem(rectangle)
        rectangle.draw()
        return rectangle
    } //]
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
        //console.log('click: (x,y)=('+x+','+y+')')
        for( var i = 0; i < items.length; i++ ) {
            var item = items[i]
            if ( item.containsPoint(x,y) ) {
                item.click(x,y)
            }
        }
        that.addRectangle({centerX:x,centerY:y,height:20,width:20})
    }) //]
    $('#'+canvasId).mousemove( function(e) { //[
        var x = e.pageX - $('#'+canvasId).offset().left 
        var y = e.pageY - $('#'+canvasId).offset().top 
        //console.log('mousemove: (x,y)=('+x+','+y+')')
        for( var i = 0; i < items.length; i++ ) {
            var item = items[i]
            if ( item.containsPoint(x,y) ) {
                item.mousemove(x,y)
            }
        }
    }) //]

} //]

PNI.Window = function(arg) { //[

    var canvas = new PNI.Canvas({canvasId:"pniview"})
    var r1 = canvas.addRectangle({centerX:10,centerY:50,width:10,height:10})

/*
    var scenario = new PNI.Scenario({canvas:canvas})

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

