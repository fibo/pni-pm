// vim: ai et sw=4 ts=4 tw=80
// vim: fdm=marker fmr=//[,//] fdc=4

/********************************************************************************


 *******************************************************************************/

var $j = jQuery.noConflict();

PNI = {};

PNI.Foo = function(arg) { //[

    console.log(arg);

}

PNI.Foo.prototype = {

}; //]

PNI.Scenario = function(arg) { //[

    this.$container = $j("#scenario-container");

    var height = this.$container.height();
    var width = this.$container.width();

    this.nodeSelector = new PNI.NodeSelector({scenario:this});
    this.nodeSelector.update();

    this.stage = new Kinetic.Stage("scenario-container",width,height);



/*


    var messageLayer = new Kinetic.Layer();
    function writeMessage(messageLayer, message){
        var context = messageLayer.getContext();
        messageLayer.clear();
        context.font = "18pt Calibri";
        context.fillStyle = "black";
        context.fillText(message, 10, 25);
    }


    var group = new Kinetic.Group({draggable:true});

    var rect1 = new Kinetic.Rect({
        x: 200,
        y: 100,
        width: 100,
        height: 50,
        fill: "orange",
        stroke: "black",
        strokeWidth: 4,
    });

    rect1.on("mouseover",function() {
this.transitionTo({scale: {x:1.5,y:1.5},duration:0.3,easing:"linear"});
    });

    rect1.on("mouseout",function() {
this.transitionTo({scale: {x:1,y:1},duration:0.3,easing:"linear"});
    });

    var rect2 = new Kinetic.Rect({
        x: 100,
        y: 75,
        width: 10,
        height: 50,
        fill: "orange",
        stroke: "black",
        strokeWidth: 4,
    });


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


    group.on("mouseover", function() {
        document.body.style.cursor = "pointer";
    });
    group.on("mouseout", function() {
        document.body.style.cursor = "default";
    });

    group.add(rect1);
    group.add(rect2);
    group.add(label);

    // add the shape to the layer
    layer.add(group);
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

        var that = this;

        $j.getJSON('/add_node',requestData, function(responseData){

            var arg = responseData;
            arg.x = position.x;
            arg.y = position.y;
            arg.scenario = that;

            var node = new PNI.Node(arg);

        });

    }

}; //]

PNI.NodeSelector = function(arg) { //[

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

PNI.Node = function(arg) { //[

    var height = 40;
    var width = 100;
    var x = arg.x;
    var y = arg.y;
    var centerX = x + width / 2;
    var centerY = y + height / 2;

    this.ins = arg.ins;
    this.outs = arg.outs;

    this.scenario = arg.scenario;

    this.layer = new Kinetic.Layer();

    this.group = new Kinetic.Group({draggable:true});

    this.label = new Kinetic.Text({
        x: centerX,
        y: centerY,
        text: arg.label,
        fontSize: 30,
        fontFamily: "Calibri",
        textFill: "black",
        align: "center",
        verticalAlign: "center"
    });

    this.box = new Kinetic.Rect({
        x: x,
        y: y,
        height: height,
        width: width,
        fill: "orange",
        stroke: "black",
        strokeWidth: 4,
    });

    this.group.add(this.box);
    this.group.add(this.label);

    this.layer.add(this.group);
    this.scenario.stage.add(this.layer);

}

PNI.Node.prototype = {}; //]

