// vim: ai et sw=4 ts=4

//var $j= jQuery.noConflict();
jQuery(document).ready( function () {
console.log("Welcome to Perl Node Interface!");
var pni = new PNI.View();
//pni.addNode();
var nodes = [];
//jQuery.getJSON('/node_list',function(data){ console.log(data); });

jQuery.getJSON('/add_node',{type:"Perlfunc::Cos"},
function(data){
console.log(data)
pni.addNode(data);
});

});
