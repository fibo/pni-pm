// vim: ai et sw=4 ts=4

var $j= jQuery.noConflict();
$j(document).ready( function () {

var w=100;
var h=100;
$j("#container").append("<p>hello</p>");
    $j("#comment").draggable();

    //var w = new PNI.Window();
    var foo = new PNI.Emitter(); 

    foo.on("start","bar",function(){console.log("bar")});
    //window.addEventListener("click",function(){console.log("ok")})
    foo.emit("bar");

});
