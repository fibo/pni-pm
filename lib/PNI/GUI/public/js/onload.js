// vim: ai et sw=4 ts=4

var $j= jQuery.noConflict();

$j(document).ready( function () {

    $j("#tabs").tabs();
    $j("#accordion").accordion({fillSpace:"true"});

    var rootScenario = new PNI.Scenario({id:"root"});

    //var edge = new PNI.Edge({startX:10,startY:50,endX:100,endY:150});
    //rootScenario.stage.add(edge.layer)
    //edge.draw();

});
