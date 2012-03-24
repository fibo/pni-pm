// vim: ai et sw=4 ts=4 tw=80
// vim: fdm=marker fmr=//[,//] fdc=4

/********************************************************************************


 *******************************************************************************/

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
        fontSize: 30,
        nodeBoxTransitionDuration: 0.2,
        nodeFill: "orange",
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

                that.addNode({type:ui.item.value},{x:x,y:y});

            }

        });

    });
}

PNI.Scenario.prototype = {

    addNode: function(requestData,position) {

        // TODO vat controllerRoute = '/scenario/'+this.id+'/add_node';
        var controllerRoute = '/add_node';

        var that = this;

        $j.getJSON(controllerRoute,requestData,function(responseData) {

            var arg = responseData;
            arg.x = position.x;
            arg.y = position.y;
            arg.scenario = that;

            var node = new PNI.Node(arg);

        });

    },

    update: function() {

        // TODO vat controllerRoute = '/scenario/'+this.id+'/to_json';
        var controllerRoute = '/root/to_json';

        var requestData = {};

        var that = this;

        $j.getJSON('/root/to_json',requestData, function(responseData){

            for ( var i in responseData.nodes ) {
            //var node = new PNI.Node(arg);
                var node = responseData.nodes[i];
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

}; //]

// PNI.Node //[

PNI.Node = function(arg) {

    PNI.Elem.call(this,arg);

    if( arg.label.length === 0 ) { arg.label = arg.type; }

    var height = 40;
    var width = arg.label.length * PNI.Theme.fontSize;
    var x = arg.x;
    var y = arg.y;
    var centerX = x + width / 2;
    var centerY = y + height / 2;

    this.ins = arg.ins;
    this.outs = arg.outs;

    this.scenario = arg.scenario;

    this.layer = new Kinetic.Layer();
    // TODO this.infoLayer = new Kinetic.Layer();
    // this.mainLayer = new Kinetic.Layer();

    this.group = new Kinetic.Group({draggable:true});

    this.label = new Kinetic.Text({ //[
        x: centerX,
        y: y,
        text: arg.label,
        fontSize: PNI.Theme.fontSize,
        fontFamily: PNI.Theme.fontFamily,
        textFill: PNI.Theme.textFill,
        align: "center",
        verticalAlign: "top",
    }); //]

    this.box = new Kinetic.Rect({ //[
        x: x,
        y: y,
        height: height,
        width: width,
        fill: PNI.Theme.nodeFill,
        stroke: "black",
        strokeWidth: PNI.Theme.strokeWidth,
    }); //]

    // this.group.on("mouseover", function() { document.body.style.cursor = "pointer"; });

    // this.group.on("mouseout", function() { document.body.style.cursor = "default"; });

    this.group.add(this.box);
    this.group.add(this.label);

    this.layer.add(this.group);
    this.scenario.stage.add(this.layer);

}

PNI.Node.prototype = {};

PNI.extend(PNI.Elem,PNI.Node);

//]

