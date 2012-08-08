PNI={};
PNI.nodeSelectorIsVisible=false;
PNI.scenarioId=1;
PNI.nodes=[];
window.requestAnimFrame=function(callback){
	return window.requestAnimationFrame
	||window.webkitRequestAnimationFrame
	||window.mozRequestAnimationFrame
	||window.oRequestAnimationFrame
	||window.msRequestAnimationFrame
	||function(callback){window.setTimeout(callback,1000/60);};
}
PNI.x=100;//prova
PNI.y=100;//prova
PNI.Scenario=function(){
	this.nodes=[];
	// Init scenario.
	var $scenario=$('#scenario');
	// Init canvas scenario.
	var canvas=document.getElementById('edges-layer');
	canvas.height=$scenario.height();
	canvas.width=$scenario.width();
	PNI.context2d=canvas.getContext('2d');
	//PNI.context2d.fillRect(PNI.x,PNI.y,PNI.x+100,PNI.y+100);
	//////////////
	var that=this;
	//////////////
//this.getNodes=function(){return nodes;}
this.addNode=function(arg){
	//console.log('PNI.addNode');
	//console.log(arg);
	var requestData=arg;
	requestData.scenario_id=1;//TODO per ora e' sempre 1
	$.ajax({
		type:'POST',
		url:'/node',
		data:requestData,
		success:function(model){
			// POST /node returns node model data on success
			console.log(model);
			that.animate();
			// Add node to scenario nodes.
			that.nodes.push(model);
			console.log(that);
			var $scenario=$('#scenario');
			var $node=$('<div/>',{
				id:model.id
			});
			var fontSize=10;// TODO ho messo questo valore a caso
			var height=30;
			var width=(model.label.length+2)*fontSize;
			$node
				.addClass('ui-widget-content')
				.addClass('draggable')
				.addClass('node')
				.height(height)
				.width(width)
        			.css({left:model.x,top:model.y})
			;
			var $label=$('<p/>',{
				text:model.label
			});
			$label
				.css({'text-align':'center'})
			;
			$node.append($label);
			$scenario.append($node);
			$node
				.draggable({containment:'parent'})
				.click(function(ev){
					console.log('node click');
					ev.stopPropagation();
				})
			;
		}
	});
}
	// Init node selector.
	var $nodeSelector=$('#node-selector');
	var $nodeSelectorInput=$('#node-selector-input');
	$nodeSelector.hide();
	$nodeSelectorInput.autocomplete({
		select:function(ev,ui){
			$nodeSelector.hide();
			that.addNode({
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
		var $nodeSelector=$('#node-selector');
		if(PNI.nodeSelectorIsVisible){
			$nodeSelector
				.hide()
			;
			PNI.nodeSelectorIsVisible=false;
		}
		else{ // Show node selector.
			$nodeSelector
				.show()
        			.css({left:x,top:y})
			;
			var $nodeSelectorInput=$('#node-selector-input');
			$nodeSelectorInput
				.val('')
				.focus()
			;
			PNI.nodeSelectorIsVisible=true;
		}
	});

}
PNI.Window=function(){
	this.scenario=new PNI.Scenario();
	var that=this;
	this.scenario.animate=function(){
	//this.renderEdgesLayer=function(){
	// TODO cicla sugli edge e disegnali, prendendo le posizioni dei nodi.
	var canvas=document.getElementById('edges-layer');
	var context2d=canvas.getContext('2d');
	

	//context2d.fillRect(10,10,100,100);
	

	//var nodes=that.scenario.getNodes();
	//for(var i in nodes){
	var nodes=that.scenario.nodes;
	for(var i in nodes){
	var node=nodes[i];
	console.log(node);
	context2d.fillRect(node.x-10,node.y-10,100,100);
	}
	/**************
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
	/**************/
//}
console.log('animate');
		//that.scenario.renderEdgesLayer();
		//requestAnimFrame(that.animate);//TODO commenta spiegando sto passaggio intrippante.
	}
}
/*
var render=function(){}
(function animloop(){
      requestAnimFrame(animloop);
      render();
    })();
    // place the rAF *before* the render() to assure as close to 
    // 60fps with the setTimeout fallback.
*/
