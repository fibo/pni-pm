// vim: ai et sw=4 ts=4

//var $j= jQuery.noConflict();
jQuery(document).ready( function () {

    var $body = $j('body');
    $body.css({font:fontSize+"px monospace"});
    
    var $container = $j('<div></div>')
    .attr('id','container')
    .appendTo($body)
    ;

    var rootScenario = new PNI.Scenario({$parentContainer:$container});

//pni.addNode();
//jQuery.getJSON('/node_list',function(data){ console.log(data); });

/*
jQuery.getJSON('/add_node',{type:"Perlfunc::Cos"},
function(data){
data.$scenario=pni.$scenario;
console.log(data)
pni.addNode(data);
});

jQuery.getJSON('/add_node',{type:"Perlfunc::Sin"},
function(data){
data.$scenario=pni.$scenario;
console.log(data)
pni.addNode(data);
});
*/
});
