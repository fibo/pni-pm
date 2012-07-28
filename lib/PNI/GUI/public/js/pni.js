PNI={};
PNI.nodeSelectorIsVisible=false;
PNI.scenarioId=1;
PNI.requestAnimFrame=function(callback){
	return window.requestAnimationFrame
	||window.webkitRequestAnimationFrame
	||window.mozRequestAnimationFrame
	||window.oRequestAnimationFrame
	||window.msRequestAnimationFrame
	||function(callback){window.setTimeout(callback,1000/60);};
}
PNI.addNode=function(arg){
	console.log('PNI.addNode');
	console.log(arg);
	var $scenario=$('#scenario');
	var node=$('<div></div)');
	node
		.addClass('ui-widget-content')
		.addClass('draggable')
		.addClass('node')
		.height(100)
		.width(100)
        	.css({left:arg.x,top:arg.y})
		.draggable({containment:'parent'})
	;
	$scenario.append(node);
	node
		.draggable({containment:'parent'})
	;
}
PNI.x=100;//prova
PNI.y=100;//prova
PNI.initWindow=function(){
	// Init scenario.
	var $scenario=$('#scenario');
	// Init canvas scenario.
	var canvas=document.getElementById('edges-layer');
	canvas.height=$scenario.height();
	canvas.width=$scenario.width();
	PNI.context2d=canvas.getContext('2d');
	// Init node selector.
	var $nodeSelector=$('#node-selector');
	var $nodeSelectorInput=$('#node-selector-input');
	$nodeSelector.hide();
	$nodeSelectorInput.autocomplete({
		select:function(ev,ui){
			$nodeSelector.hide();
			PNI.addNode({
				type: ui.item.value,
				x:PNI.x,
				y:PNI.y
			});
		},
		source:'node_list'
	});
	//
	$scenario.click(function(ev){
        	var $offset=$scenario.offset();
        	var x=ev.pageX-$offset.left; 
        	var y=ev.pageY-$offset.top;
		PNI.x=x;PNI.y=y;
		// Show node selector.
		var $nodeSelectorInput=$('#node-selector-input');
		$nodeSelectorInput
			.val('')
			.focus()
		;
		var $nodeSelector=$('#node-selector');
		$nodeSelector
			.show()
        		.css({left:x,top:y})
		;
	});
}
PNI.renderEdgesLayer=function(){
	// TODO cicla sugli edge e disegnali, prendendo le posizioni dei nodi.
	var startX=100,startY=100,endX=200,endY=200;
        PNI.context2d.beginPath();
        PNI.context2d.moveTo( startX, startY );
        PNI.context2d.bezierCurveTo(
            startX, 
            (startY+endY)/2, 
            endX, 
            (startY+endY)/2, 
            endX, 
            endY
        );
	PNI.context2d.stroke();
	//PNI.context2d.fillRect(PNI.x,PNI.y,PNI.x+10,PNI.y+10);
}
PNI.Window=function(){
	this.foo="bazr";
	var that=this;
	that.animate=function(){
		PNI.renderEdgesLayer();
		PNI.requestAnimFrame(that.animate);//TODO commenta spiegando sto passaggio intrippante.
	}
}
PNI.Window.prototype={
}
