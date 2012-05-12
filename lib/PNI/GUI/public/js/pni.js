// vim: ai et sw=4 ts=4 tw=80
// vim: fdm=marker fmr=//[,//] fdc=4

var $j = jQuery.noConflict();

//require(['THREE/Scene']);

// PNI //[

PNI = {

    // Global map id <--> object.
    // TODO si potrebbe anche togliere, sarebbe meglio.
    // in particolare l' edge deve essere creato da zero, e il semiEdge deve
    // essere una classe a parte.
    elemById: {},

    extend: function(subClass, superClass){

        for (var key in superClass.prototype) {

            if (superClass.prototype.hasOwnProperty(key)) {

                subClass.prototype[key] = superClass.prototype[key];

            }
        }
    },

    Theme: {

        fontFamily: "Calibri",
        fontSize: 12,

        edgeStrokeStyle: "blue",
        edgeLineWidth: 2,

        nodeBoxTransitionDuration: 0.2,
        nodeFill: "orange",
        nodeHeight: 30,

        slotSide: 10,
        strokeWidth: 2,
        textFill: "black",

    }

};

//]

// PNI.Elem //[

PNI.Elem = function(arg) { 

    this.model = arg.model;
    this.scenario = arg.scenario;

    // TODO aggiustare bene sta cosa dell id, soprattuto per l' edge visto che
    // glielo aggiungo dopo
    if( ( typeof this.model != "undefined" ) && ( typeof this.model.id != "undefined" ) ) {
        PNI.elemById[this.model.id] = this;
    }

}

PNI.Elem.prototype = { };

//]

// PNI.Scenario //[

PNI.Scenario = function(arg) { //[

    // Set default model.
    if( typeof arg.model == "undefined" ) {
        arg.model = {
            id: 1,
            nodes: [],
            edges: []
        }
    }

    PNI.Elem.call(this,arg);

    this.$container = $j("#scenario");

    var height = this.$container.height();
    var width = this.$container.width();

    this.nodeSelector = new PNI.NodeSelector({scenario:this});
    this.nodeSelector.update();

    this.edges = [];
    this.nodes = [];

    this.stage = new Kinetic.Stage("scenario",width,height);
    this.layer = new Kinetic.Layer();

    this.currenSlot = undefined;
    this.currenNode = undefined;
    this.semiEdge = undefined;

    this.updateView();

    var that = this;

    this.$container
    .dblclick( function(evt) {

        var nodeSelector = that.nodeSelector;

        // Doubleclick toggles nodeSelector visibility.
        if( nodeSelector.isVisible ) {
            nodeSelector.hide();
            return;
        }

        var $offset = that.$container.offset();
        var x = evt.pageX - $offset.left; 
        var y = evt.pageY - $offset.top;

        // Update nodeSelector position and show it.
        nodeSelector.x = x;
        nodeSelector.y = y;
        nodeSelector.show();

        nodeSelector.$input.autocomplete({ 

            select: function( evt, ui ) {

                nodeSelector.hide();

                that.addNode({
                    type: ui.item.value,
                    x: x,
                    y: y
                });
            }
        });
    })
    .keypress( function( evt ) {

        if( evt.charCode == 13 ) {

            if ( that.nodeSelector.isVisible === false ) {
                that.runTask();
                that.updateView();
            }

        }

        if( evt.charCode == 36 ) {

            if ( that.nodeSelector.isVisible === true ) {

                // TODO fai che passi tutto in un unico parametro request
                //var insJSON = JSON.stringify([{label:"in",data:that.nodeSelector.$input.val()}]);

                that.addNode({
                    type:"Perldata::Scalar",
                    x:that.nodeSelector.x,
                    y:that.nodeSelector.y
                });

                that.nodeSelector.hide();

            }

        }
        if( evt.charCode == 37 ) {
            console.log("TODO: create hash (dove si trova il mouse)");
        }
        if( evt.charCode == 64 ) {
            console.log("TODO: create array (dove si trova il mouse)");
        }
    });
} //]

PNI.Scenario.prototype = {

    // TODO dovrebbe chiamarsi addNodeToModel ??
    addNode: function(requestData) { //[

        requestData.scenario_id = this.model.id;

        var that = this;

        $j.ajax({
            type: 'POST',
            url: '/node',
            data: requestData,
            success: function(responseData) {

                var arg = {};
                arg.model = responseData;
                arg.scenario = that;
                var node;

                if( arg.model.type == "Perldata::Scalar" ) {
                    node = new PNI.Node.Perldata.Scalar(arg);
                }
                else {
                    node = new PNI.Node(arg);
                }

                that.nodes.push(node);
            }
        });

    }, //]

    //getModel: function() { },

    runTask: function() {

        var requestData = {};

        var that = this;
        //TODO uniformala scrivendola come 'GET'
        // ma bisogna fare una GET ?
        $j.getJSON( 
            '/scenario/'+that.model.id+'/task', 
            requestData, function(responseData) {
                that.model = responseData;
                that.renderView();
            });

    },

    updateView: function() { //[



        // TODO per ora devo resettare nodes e edges
        this.nodes=[];
        this.edges=[];

        var requestData = {};

        var controllerRoute = '/scenario/'+this.model.id;

        var that = this;

        /*
        * TODO uniformala alle altre, dovrebbe essere qualcosa del genere
        $j.ajax(
        type: 'GET',
        url: '/scenario',
        success: function(responseData) 
        */

        $j.getJSON( controllerRoute, requestData, function(responseData) {

            that.model = responseData;
            that.renderView();
        });
    }, //]

    renderView: function() {

        for ( var i in this.model.nodes ) {

            var model = this.model.nodes[i];
            // TODO dovrebbe funzionare prendere il nodo da PNI.elemById
            var node;

            var arg = {};
            arg.scenario = this;
            arg.model = model;

            if( model.type == "Perldata::Scalar" ) {
                node = new PNI.Node.Perldata.Scalar(arg);
            }
            else {
                node = new PNI.Node(arg);
            }
            this.nodes.push(node);
        }

        for ( var i in this.model.edges ) {

            var model = this.model.edges[i];
            // TOD var edge = PNI.elemById[model.id];

            var arg = {};
            arg.source = PNI.elemById[model.source_id];
            arg.target = PNI.elemById[model.target_id];
            arg.scenario = this;
            arg.model = model;

            var edge = new PNI.Edge(arg);
            edge.drawLine();

            this.edges.push(edge);
        } 
    }

};

PNI.extend(PNI.Scenario,PNI.Elem);

//]

// PNI.NodeSelector //[

PNI.NodeSelector = function(arg) {

    this.x = undefined;
    this.y = undefined;
    this.scenario = arg.scenario;

    this.$container = $j("#node-selector");
    this.$container.hide();

    this.$input = $j("#node-selector-input");

    var that = this;

    this.isVisible = false;

}

PNI.NodeSelector.prototype = {

    hide: function() { 

        this.isVisible = false;

        this.$input.autocomplete("close");
        this.$input.val("");

        this.$container.hide();

    },

    show: function() {

        this.isVisible = true;

        this.$input.val("");

        this.$container
        .css({left:this.x,top:this.y})
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

    PNI.Elem.call( this, arg );

    this.layer = new Kinetic.Layer();
    this.label = this.model.label || 'Node';
    this.height = PNI.Theme.nodeHeight;
    this.width = Math.max( this.model.label.length * PNI.Theme.fontSize, 3 * PNI.Theme.slotSide );

    // Force x and y to be numbers since they come from JSON data.
    // TODO in teoria ora dovrebbe essere ok lato server
    //this.x = Number(arg.x);
    //this.y = Number(arg.y);
    this.x = this.model.x;
    this.y = this.model.y;

    this.ins = [];
    this.outs = [];

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
            text: this.model.label,
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

        for ( var i in this.model.ins ) {

            var arg = {};
            arg.model = this.model.ins[i];
            arg.stage = this.stage;
            arg.layer = this.layer;
            arg.node = this;
            arg.order = i;
            arg.scenario = this.scenario;

            var slot = new PNI.In(arg);
            this.ins.push(slot);
            this.group.add(slot.box);

        }

    //]

    // Create out slots //[

        for ( var i in this.model.outs ) {

            var arg = {};
            arg.model = this.model.outs[i];
            arg.stage = this.stage;
            arg.layer = this.layer;
            arg.node = this;
            arg.order = i;
            arg.scenario = this.scenario;

            var slot = new PNI.Out(arg);
            this.outs.push(slot);
            this.group.add(slot.box);

        }

    //]

    this.layer.add(this.group);
    this.scenario.stage.add(this.layer);

    var that = this;

    this.group.on( "mouseover", function(evt) { document.body.style.cursor = "pointer"; });
    this.group.on( "mouseout", function(evt) { document.body.style.cursor = "default"; });
    this.group.on( "dragmove", function(evt) {

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
    this.group.on( "dragend",function(evt) {

        var requestData = {x:that.x,y:that.y};

        $j.ajax({
            type: 'PUT',
            url: '/node/'+that.model.id,
            data: requestData
        });

    });
}

PNI.Node.prototype = { };

PNI.extend(PNI.Node,PNI.Elem);

//]

PNI.Node.Perldata = {};

PNI.Node.Perldata.Scalar = function(arg) {

    PNI.Node.call( this, arg );

    this.$dataEditor = $j('<div class="ui-widget"></div>')
    .css({top:this.y,left:this.x+this.height})
    .css({height:this.height,width:10})
    .css({position:"absolute",display:"block"})
    .appendTo(this.scenario.$container)
    .show()
    ;

    this.$dataEditorInput = $j('<input>')
    .attr( 'id', this.model.id )
    .appendTo(this.$dataEditor)
    .val(this.model.ins[0].data)
    .show()
    .focus()
    ;

    var that = this;

    this.$dataEditorInput
    .click( function(evt) { that.$dataEditorInput.focus(); } )
    .focusout( function(evt) {

        // Update model if input data is changed.
        if( that.model.ins[0].data != that.$dataEditorInput.val() ) {

            that.model.ins[0].data = that.$dataEditorInput.val();
            var requestData = { data: that.model.ins[0].data };

            // TODO dovrebbe essere un metodo gestito da PNI.Slot
            $j.ajax({
                type: 'POST',
                url: '/slot/'+that.model.ins[0].id+'/data',
                data: requestData,
                success: function(responseData) {}
            });

        } 
    })
    ;

    this.group.on( "dragmove", function(evt) {

        // TODO questo e' preso dalla classe padre, CERCA DI FARE QUALCOSA PIU FURBO,
        // tipo usare il prototype

        // Update node position.
        var position = that.box.getAbsolutePosition();
        that.y = position.y;
        that.x = position.x;

        that.$dataEditor.css({top:that.y,left:that.x+that.height});

        // Draw out edges.
        for ( var i in that.outs ) {

            for (  var j in that.outs[i].edges ) {

                that.outs[i].edges[j].drawLine();

            }
        }

    });

    /*
    var label;
    var inId = arg.ins[0];

    $j.ajax({
    type: 'GET',
    url: '/slot/'+inId+'/data',
    success: function(responseData) {

    // TODO BRUTTISSIMA SOLUZIONE ma basta che funzioni per ora
    label = responseData;
    arg.label = label;
    PNI.Node.call( this, arg );
    }
    });
    */

}

PNI.Node.Perldata.Scalar.prototype = {};

PNI.extend(PNI.Node.Perldata.Scalar,PNI.Node);

// PNI.Slot //[

PNI.Slot = function(arg) {

    PNI.Elem.call(this,arg);

    this.node = arg.node;
    this.order = arg.order;
    this.data = arg.data;

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

    this.box.on("mouseover", function(evt) {

        that.scenario.currenSlot = that;

    });

    this.box.on("mouseout", function(evt) {

        that.scenario.currenSlot = undefined;

    });

}

PNI.Slot.prototype = { 

    getData: function() { 

        var that = this;

        $j.ajax({
            type: 'GET',
            url: '/slot/'+that.model.id+'/data',
            success: function(responseData) {

                that.data = responseData;

            }
        });

        return this.data;
    },

    getX: function() {

        var x = this.node.x;

        if( this.order > 0 ) {
            x += this.order * ( this.node.width - PNI.Theme.slotSide ) / ( this.node.model.ins.length - 1 ); 
        }

        return x;

    }

};

PNI.extend(PNI.Slot,PNI.Elem);

//]

// PNI.In //[

PNI.In = function(arg) {

    PNI.Slot.call( this, arg );

    this.edge;

    var that = this;

    this.box.on( "click" , function() {

        if( typeof that.scenario.semiEdge != "undefined" ) {

            // Turn semiEdge into an edge and add its target.
            var edge = that.scenario.semiEdge;
            that.scenario.semiEdge = undefined;
            edge.target = that;

            // TODO dovrei usare questo ma non funziona
            // anche se documentato:
            // that.scenario.stage.off( "mousemove" );
            that.scenario.stage.on( "mousemove" , function() {} );


            var requestData = {
                scenario_id: edge.scenario.model.id,
                source_id: edge.source.model.id,
                target_id: edge.target.model.id
            };

            $j.ajax({
                type: 'POST',
                url: '/edge',
                data: requestData,
                success: function(responseData) {
                    edge.model = responseData; 
                    PNI.elemById[edge.model.id] = edge;
                }
            });
        }
    });

}

PNI.In.prototype = { 

    getY: function() { return this.node.y - PNI.Theme.slotSide; }

};

PNI.extend(PNI.In,PNI.Slot);

//]

// PNI.Out //[

PNI.Out = function(arg) {

    PNI.Slot.call( this, arg );

    this.edges = [];

    var that = this;

    this.box.on( "click", function(evt) {

        var arg = {};
        arg.scenario = that.scenario;
        arg.source = that;
        var edge = new PNI.Edge(arg);
        edge.drawLine();
        that.edges.push(edge);

    });

}

PNI.Out.prototype = {

    getY: function() { return this.node.y + this.node.height; }

};

PNI.extend( PNI.Out, PNI.Slot );

//]

// PNI.Edge //[

PNI.Edge = function(arg) { //[

    PNI.Elem.call( this, arg );

    this.source = arg.source;
    this.target = arg.target;

    this.layer = new Kinetic.Layer();

    var that = this;

    if( this.target !== "undefined" ) {

        this.scenario.stage.on( "mousemove", function(evt) {
            that.drawLine();
        });

        this.scenario.semiEdge = this;

    }

    this.scenario.stage.add(this.layer);
} //]

PNI.Edge.prototype = {

    drawLine: function() { //[

        var context = this.layer.getContext();
        this.layer.clear();

        var startX = this.source.getX() + ( PNI.Theme.slotSide / 2 );
        var startY = this.source.getY() + ( PNI.Theme.slotSide / 2 );

        var endY = this.getEndY();
        var endX = this.getEndX();

        context.beginPath();
        context.moveTo( startX, startY );
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

    }, //]

    getEndY: function() { //[

        if ( typeof this.target !== "undefined" ) {

            return this.target.getY() + ( PNI.Theme.slotSide / 2 );

        }
        else {

            var position = this.scenario.stage.getMousePosition();
            return position.y;

        }

    }, //]

    getEndX: function() { //[

        if ( typeof this.target !== "undefined" ) {

            return this.target.getX() + ( PNI.Theme.slotSide / 2 );

        }
        else {

            var position = this.scenario.stage.getMousePosition();
            return position.x;

        }

    } //]

};

PNI.extend( PNI.Edge, PNI.Elem );

//]

