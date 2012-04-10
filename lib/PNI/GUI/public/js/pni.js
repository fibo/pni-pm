// vim: ai et sw=4 ts=4 tw=80
// vim: fdm=marker fmr=//[,//] fdc=4

var $j = jQuery.noConflict();

// PNI //[

PNI = {

    extend: function(subClass, superClass){

        for (var key in superClass.prototype) {

            if (superClass.prototype.hasOwnProperty(key)) {

                subClass.prototype[key] = superClass.prototype[key];

            }
        }
    },

    Theme: {

        fontFamily: "Calibri",
        fontSize: 20,

        edgeStrokeStyle: "blue",
        edgeLineWidth: 4,

        nodeBoxTransitionDuration: 0.2,
        nodeFill: "orange",

        slotSide: 10,
        strokeWidth: 4,
        textFill: "black",

    }

};

//]

// PNI.Elem //[

PNI.Elem = function(arg) { 

    this.id = arg.id;

}

PNI.Elem.prototype = { };

//]

// PNI.Scenario //[

PNI.Scenario = function(arg) { 

    PNI.Elem.call(this,arg);

    this.$container = $j("#scenario-container");

    var height = this.$container.height();
    var width = this.$container.width();

    this.nodeSelector = new PNI.NodeSelector({scenario:this});
    this.nodeSelector.update();

    this.nodes = [];

    this.stage = new Kinetic.Stage("scenario-container",width,height);

    this.update();

/*


    var messageLayer = new Kinetic.Layer();
    function writeMessage(messageLayer, message){
        var context = messageLayer.getContext();
        messageLayer.clear();
        context.font = "18pt Calibri";
        context.fillStyle = "black";
        context.fillText(message, 10, 25);
    }



    var circle = new Kinetic.Circle({
        x: 180,
        y: 200,
        radius: 70,
        fill: "red",
        stroke: "black",
        strokeWidth: 4
    });

    circle.on("mouseover", function(){
        writeMessage(messageLayer, "Mouseover circle");
    });
    circle.on("mouseout", function(){
        writeMessage(messageLayer, "Mouseout circle");
    });
    circle.on("mousedown", function(){
        writeMessage(messageLayer, "Mousedown circle");
    });
    circle.on("mouseup", function(){
        writeMessage(messageLayer, "Mouseup circle");
    });

    layer.add(circle);

    // add the layer to the stage
    this.stage.add(messageLayer);

*/

    var that = this;

    that.$container.dblclick( function(e) {

        var $offset = that.$container.offset();
        var x = e.pageX - $offset.left; 
        var y = e.pageY - $offset.top;

        that.nodeSelector.show(x,y);

        that.nodeSelector.$input.autocomplete({ 

            select: function(ev,ui) {

                that.nodeSelector.hide();

                that.addNode({type:ui.item.value,x:x,y:y});

            }

        });

    });
}

PNI.Scenario.prototype = {

    addNode: function(requestData) {

        var controllerRoute = '/scenario/'+this.id+'/add_node';

        var that = this;

        $j.getJSON(controllerRoute,requestData,function(responseData) {

            var node = new PNI.Node(responseData);
            that.nodes.push(node);
            that.stage.add(node.layer);

        });

    },

    addEdge: function(requestData) {

        var controllerRoute = '/scenario/'+this.id+'/add_edge';

        var that = this;

        $j.getJSON(controllerRoute,requestData,function(responseData) {

            var edge = new PNI.Edge(responseData);
            that.edges.push(edge);
            that.stage.add(edge.layer);

        });

    },

    update: function() {

        var controllerRoute = '/scenario/'+this.id;

        var requestData = {};

        var that = this;

        $j.getJSON(controllerRoute,requestData, function(responseData){

            for ( var i in responseData.nodes ) {
                
                var arg = responseData.nodes[i];
                //arg.scenario = that;
                //var node = new PNI.Node(arg);
            } 

        });

    }

};

PNI.extend(PNI.Scenario,PNI.Elem);

//]

// PNI.NodeSelector //[

PNI.NodeSelector = function(arg) {

    this.$container = $j("#node-selector-container");
    this.$container.hide();

    this.$input = $j("#node-selector-input");

}

PNI.NodeSelector.prototype = {

    hide: function() { this.$container.hide(); },

    show: function(x,y) { 

        this.$container
        .css({left:x,top:y})
        .show()
        ;

        this.$input.focus();
    },

    update: function() {

        var that = this;

        $j.getJSON( 'node_list', function(nodeList) { 

                that.$input.autocomplete({source:nodeList}); 

        });

    }

}; 

//]

// PNI.Node //[

PNI.Node = function(arg) {

    PNI.Elem.call(this,arg);

    var height = 40;

    // Node width is at least 3 times slotSide which seems a good choice 
    // for one char label nodes and it grows to adapt to label length.
    var width = Math.max( arg.label.length * PNI.Theme.fontSize, 3 * PNI.Theme.slotSide );

    // Force x and y to be numbers since they come from JSON data.
    var x = Number(arg.x);
    var y = Number(arg.y);

    var centerX = x + width / 2;
    var centerY = y + height / 2;

    this.ins = [];
    this.outs = [];

    this.layer = new Kinetic.Layer();
    // TODO this.infoLayer = new Kinetic.Layer();
    // this.mainLayer = new Kinetic.Layer();

    this.group = new Kinetic.Group({draggable:true});

    // Create box. //[

        this.box = new Kinetic.Rect({ 
            x: x,
            y: y,
            height: height,
            width: width,
            fill: PNI.Theme.nodeFill,
            stroke: "black",
            strokeWidth: PNI.Theme.strokeWidth,
        });

        this.group.add(this.box);

    //]

    // Create label. //[

        this.label = new Kinetic.Text({
            x: centerX,
            y: y,
            text: arg.label,
            fontSize: PNI.Theme.fontSize,
            fontFamily: PNI.Theme.fontFamily,
            textFill: PNI.Theme.textFill,
            align: "center",
            verticalAlign: "top",
        });

        this.group.add(this.label);

    //]

    // this.group.on("mouseover", function() { document.body.style.cursor = "pointer"; });

    // this.group.on("mouseout", function() { document.body.style.cursor = "default"; });

    // Create in slots //[

        for ( var i in arg.ins ) {

            // TODO arg.ins[i] for slot label, add it to info layer

            var slotX = x;

            if ( arg.ins.length > 1 ) { 
                slotX += i * ( width - PNI.Theme.slotSide ) / ( arg.ins.length - 1 ); 
            }

            var slotY = y - PNI.Theme.slotSide;

            var slot = new PNI.In({x:slotX,y:slotY});

            this.ins.push(slot);
            this.group.add(slot.box);

        }

    //]

    // Create out slots //[

        for ( var i in arg.outs ) {

            // TODO arg.outs[i] for slot label, add it to info layer

            var slotX = x;

            if ( arg.outs.length > 1 ) { 
                slotX += i * ( width - PNI.Theme.slotSide ) / ( arg.outs.length - 1 ); 
            }

            var slotY = y + height;

            var slot = new PNI.Out({x:slotX,y:slotY});
console.log(slot);
            this.outs.push(slot);
            this.group.add(slot.box);

        }

    //]

    this.layer.add(this.group);

}

PNI.Node.prototype = {};

PNI.extend(PNI.Node,PNI.Elem);

//]

// PNI.Slot //[

PNI.Slot = function(arg) {

    PNI.Elem.call(this,arg);

    this.infoLayer = new Kinetic.Layer();

    this.box = new Kinetic.Rect({ 
        x: arg.x,
        y: arg.y,
        height: PNI.Theme.slotSide,
        width: PNI.Theme.slotSide,
        fill: PNI.Theme.nodeFill,
        stroke: "black",
        strokeWidth: PNI.Theme.strokeWidth,
    });

    var that = this;

    this.box.on("mouseover",function(){
    
        that.showInfo();

    });

}

PNI.Slot.prototype = { 

    infoMessage: function() {

        return "basta sss";

    },

    showInfo: function() { 

        var infoLayer = this.infoLayer;
        infoLayer.clear();

        var context = infoLayer.getContext();
        context.font = "18pt Calibri";
        context.fillStyle = "black";
        context.fillText(this.infoMessage(), this.infoX(), this.infoY());

console.log(this.infoMessage());
console.log(this.infoX());
console.log(this.infoY());
    } 
};

PNI.extend(PNI.Slot,PNI.Elem);

//]

// PNI.In //[

PNI.In = function(arg) {

    PNI.Slot.call(this,arg);

}

PNI.In.prototype = { 
    infoX: function() { return 10; },
    infoY: function() { return 10; }
};

PNI.extend(PNI.In,PNI.Slot);

//]

// PNI.Out //[

PNI.Out = function(arg) {

    PNI.Slot.call(this,arg);

}

PNI.Out.prototype = { 
    infoX: function() { return 20; },
    infoY: function() { return 40; }
};

PNI.extend(PNI.Out,PNI.Slot);

//]

// PNI.Edge //[

PNI.Edge = function(arg) {

    PNI.Elem.call(this,arg);

    this.layer = new Kinetic.Layer();

    this.startX = arg.startX;
    this.startY = arg.startY;
    this.endX = arg.endX;
    this.endY = arg.endY;

}

PNI.Edge.prototype = {

    draw: function () {

        var context = this.layer.getContext();

        this.layer.clear();

        context.beginPath();
        context.moveTo(this.startX, this.startY);
        context.bezierCurveTo(
            this.startX, 
            (this.startY+this.endY)/2, 
            this.endX, 
            (this.startY+this.endY)/2, 
            this.endX, 
            this.endY
        );
        context.strokeStyle = PNI.Theme.edgeStrokeStyle;
        context.lineWidth = PNI.Theme.edgeLineWidth;
        context.stroke();

    }

};

PNI.extend(PNI.Edge,PNI.Elem);

//]

