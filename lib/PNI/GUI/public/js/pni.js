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
    this.layer = arg.layer;
    this.stage = arg.stage;

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
    this.layer = new Kinetic.Layer();

    var that = this;

    this.$container.dblclick( function(e) {

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

            arg = responseData;
            arg.stage = that.stage;
            arg.layer = that.layer;
            var node = new PNI.Node(arg);
            that.nodes.push(node);

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

    }

    /*
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
    */
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

    this.height = 40;

    // Node width is at least 3 times slotSide which seems a good choice
    // for one char label nodes; it grows to adapt to label length.
    this.width = Math.max( arg.label.length * PNI.Theme.fontSize, 3 * PNI.Theme.slotSide );

    // Force x and y to be numbers since they come from JSON data.
    this.x = Number(arg.x);
    this.y = Number(arg.y);

    this.ins = arg.ins || [];
    this.outs = arg.outs || [];

    this.group = new Kinetic.Group({draggable:true});

    // Create box. //[

    this.box = new Kinetic.Rect({ 

        x: this.x,
        y: this.y,
        height: this.height,
        width: this.width,
        fill: PNI.Theme.nodeFill,
        stroke: "black",
        strokeWidth: PNI.Theme.strokeWidth,

    });

    this.group.add(this.box);

    //]

    // Create label. //[

    this.label = new Kinetic.Text({

        x: this.x + this.width / 2,
        y: this.y,
        text: arg.label,
        fontSize: PNI.Theme.fontSize,
        fontFamily: PNI.Theme.fontFamily,
        textFill: PNI.Theme.textFill,
        padding: 10,
        align: "center",
        verticalAlign: "top",

    });

    this.group.add(this.label);

    //]

    // Create in slots //[

        for ( var i in this.ins ) {

            // TODO order si potrebbe ricavare dal node, ins e id dello slot
            var arg = {};
            arg.stage = this.stage;
            arg.layer = this.layer;
            arg.node = this;
            arg.order = i;
            var slot = new PNI.In(arg);
            this.ins[i] = slot;
            this.group.add(slot.box);

        }

    //]

    // Create out slots //[

        for ( var i in this.outs ) {

            var arg = {};
            arg.stage = this.stage;
            arg.layer = this.layer;
            arg.node = this;
            arg.order = i;
            var slot = new PNI.Out(arg);
            this.outs[i] = slot;
            this.group.add(slot.box);

        }

    //]

    this.layer.add(this.group);
    this.stage.add(this.layer);

    var that = this;

    this.group.on("mouseover", function() { document.body.style.cursor = "pointer"; });
    this.group.on("mouseout", function() { document.body.style.cursor = "default"; });
    this.group.on("dragend dragmove",function(evt) {

        // Update node position.
        var position = that.box.getAbsolutePosition();
        that.y = position.y;
        that.x = position.x;

        // Draw out edges.
        for ( var i in that.outs ) {

            for (  var j in that.outs[i].edges ) {

                that.outs[i].edges[j].drawLine();

            }

        }

    });
}

PNI.Node.prototype = {};

PNI.extend(PNI.Node,PNI.Elem);

//]

// PNI.Slot //[

PNI.Slot = function(arg) {

    PNI.Elem.call(this,arg);

    this.node = arg.node;
    this.order = arg.order;

    this.box = new Kinetic.Rect({ 

        x: this.getX(),
        y: this.getY(),
        height: PNI.Theme.slotSide,
        width: PNI.Theme.slotSide,
        fill: PNI.Theme.nodeFill,
        stroke: "black",
        strokeWidth: PNI.Theme.strokeWidth,

    });

    var that = this;

}

PNI.Slot.prototype = { 

    getX: function() {

        var x = 0;

        if( this.order === 0 ) {
            x = this.node.x;
        }
        else { 
            x = this.node.x + this.order * ( this.node.width - PNI.Theme.slotSide ) / ( this.node.ins.length - 1 ); 
        }

        return x;

    }

};

PNI.extend(PNI.Slot,PNI.Elem);

//]

// PNI.In //[

PNI.In = function(arg) {

    PNI.Slot.call(this,arg);

}

PNI.In.prototype = { 

    getY: function() { return this.node.y - PNI.Theme.slotSide; }

};

PNI.extend(PNI.In,PNI.Slot);

//]

// PNI.Out //[

PNI.Out = function(arg) {

    PNI.Slot.call(this,arg);

    this.edges = [];

    var that = this;

    this.box.on("click",function() {

        var arg = {};
        arg.source = that;
        arg.stage = that.stage;
        arg.layer = that.layer;
        var edge = new PNI.Edge(arg);
        edge.drawLine();
        that.edges.push(edge);

    });

}

PNI.Out.prototype = {

    getY: function() { return this.node.y + this.node.height; }

};

PNI.extend(PNI.Out,PNI.Slot);

//]

// PNI.Edge //[

PNI.Edge = function(arg) {

    PNI.Elem.call(this,arg);

    this.source = arg.source;
    this.target = arg.target;

    var that = this;

    if( this.target !== "undefined" ) {

        this.stage.on("mousemove",function() {
            that.drawLine();
        });
    }

}

PNI.Edge.prototype = {

    drawLine: function() {

        var context = this.layer.getContext();

        var startX = this.source.getX() + ( PNI.Theme.slotSide / 2 );
        var startY = this.source.getY() + ( PNI.Theme.slotSide / 2 );

        var endY = this.getEndY();
        var endX = this.getEndX();

        context.clearRect(startX,startY,endX,endY);

        context.beginPath();
        context.moveTo(startX, startY);
        context.bezierCurveTo(
            startX, 
            (startY+endY)/2, 
            endX, 
            (startY+endY)/2, 
            endX, 
            endY
        );
        context.strokeStyle = PNI.Theme.edgeStrokeStyle;
        context.lineWidth = PNI.Theme.edgeLineWidth;
        context.stroke();

    },

    getEndY: function() { //[

        if ( typeof this.target !== "undefined" ) {

            return this.target.getY() + ( PNI.Theme.slotSide / 2 );

        }

        else {

            var position = this.stage.getMousePosition();
            return position.y;

        }

    },//]

    getEndX: function() { //[

        if ( typeof this.target !== "undefined" ) {

            return this.target.getX() + ( PNI.Theme.slotSide / 2 );

        }

        else {

            var position = this.stage.getMousePosition();
            return position.x;

        }

    } //]

};

PNI.extend(PNI.Edge,PNI.Elem);

//]

