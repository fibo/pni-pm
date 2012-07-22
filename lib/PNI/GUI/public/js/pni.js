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
PNI.addNode=function(){
	console.log('PNI.addNode');
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
// TODO per x e y ci va qualcosa tipo $nodeSelector.css.top e left
that.scenario.addNode({
	type: ui.item.value,
	x:100,
	y:100
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
		var $nodeSelector=$('#node-selector');
		$nodeSelector
			.show()
        		.css({left:x,top:y});
	});
}
PNI.renderEdgesLayer=function(){
	PNI.context2d.fillRect(PNI.x,PNI.y,PNI.x+10,PNI.y+10);
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
