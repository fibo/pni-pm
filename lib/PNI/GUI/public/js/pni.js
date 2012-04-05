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

            var arg = responseData;
            arg.scenario = that;

            var node = new PNI.Node(arg);

        });

    },

    update: function() {

        var controllerRoute = '/scenario/'+this.id;

        var requestData = {};

        var that = this;

        $j.getJSON(controllerRoute,requestData, function(responseData){

            for ( var i in responseData.nodes ) {
                
                var arg = responseData.nodes[i];
                arg.scenario = that;
                var node = new PNI.Node(arg);
console.log(node);
            } 

        });

    }

};

PNI.extend(PNI.Elem,PNI.Scenario);

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
    var width = arg.label.length * PNI.Theme.fontSize;

    // Force x and y to be numbers since they come from JSON data.
    var x = Number(arg.x);
    var y = Number(arg.y);

    var centerX = x + width / 2;
    var centerY = y + height / 2;

    this.ins = [];
    this.outs = [];

    this.scenario = arg.scenario;

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

            var slot = new Kinetic.Rect({ 
                x: slotX,
                y: slotY,
                height: PNI.Theme.slotSide,
                width: PNI.Theme.slotSide,
                fill: PNI.Theme.nodeFill,
                stroke: "black",
                strokeWidth: PNI.Theme.strokeWidth,
            });

            this.ins.push(slot);
            this.group.add(slot);

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

            var slot = new Kinetic.Rect({ 
                x: slotX,
                y: slotY,
                height: PNI.Theme.slotSide,
                width: PNI.Theme.slotSide,
                fill: PNI.Theme.nodeFill,
                stroke: "black",
                strokeWidth: PNI.Theme.strokeWidth,
            });

            this.outs.push(slot);
            this.group.add(slot);

        }

    //]

    this.layer.add(this.group);
    this.scenario.stage.add(this.layer);

}

PNI.Node.prototype = {};

PNI.extend(PNI.Elem,PNI.Node);

//]

// Per fare una bella bezier
// control1_x e' una funzione ?
// control1.x e' uguale a start.x
// control1.y e' start.y + end.y / 2
// control2.x e' end.x
// control2.y e' start.y + end.y / 2
/*

function drawCurves(curveLayer) {
            var context = curveLayer.getContext();
            curveLayer.clear();

            context.beginPath();
            context.moveTo(bezier.start.x, bezier.start.y);
            context.bezierCurveTo(bezier.control1.x, bezier.control1.y, bezier.control2.x, bezier.control2.y, bezier.end.x, bezier.end.y);
            context.strokeStyle = "blue";
            context.lineWidth = 4;
            context.stroke();
*/

// PNI.Edge //[

PNI.Edge = function(arg) {

    PNI.Elem.call(this,arg);

    this.start; // sono degli slot ? devono avere x e y ?
    this.end;
}

PNI.Edge.prototype = {
    
    aX: function () {
        return this.startX;
    }
};

PNI.extend(PNI.Elem,PNI.Edge);

//]
