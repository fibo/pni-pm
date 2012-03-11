// vim: ai et sw=4 ts=4

$(document).ready( function () {

    $("#block1").draggable();

    //var w = new PNI.Window();
    var foo = new PNI.Emitter(); 

    foo.on("start","bar",function(){console.log("bar")});
    //window.addEventListener("click",function(){console.log("ok")})
    foo.emit("bar");

});
