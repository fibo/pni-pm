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
PNI.initCanvas=function(){
}
PNI.initWindow=function(){
	// Init scenario.
	var $scenario=$('#scenario');
	// Init canvas scenario.
	var canvas=document.getElementById('edges-layer');
	canvas.height=$scenario.height();
	canvas.width=$scenario.width();
	PNI.context2d=canvas.getContext('2d');
	PNI.context2d.fillRect(10, 10, 20, 20);
	// Init node selector.
	var $nodeSelector=$('#node-selector');
	var $nodeSelectorInput=$('#node-selector-input');
	$nodeSelector.hide();
	$nodeSelectorInput.autocomplete({
		select:function(ev,ui){
			$nodeSelector.hide();
/*
            that.scenario.addNode( {
                type: ui.item.value,
                x: that.x,
                y: that.y
            } );
*/
		},
		source:'node_list'
	});
	//
	$scenario.click(function(ev){
		console.log('click');
	var $nodeSelector=$('#node-selector');
		$nodeSelector.show()
        .css({left:100,top:100} );
	});
}
