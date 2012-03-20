// vim: ai et sw=4 ts=4

var $j= jQuery.noConflict();

$j(document).ready( function () {

    $j("#tabs").tabs({event:"mouseover"});
    $j("#accordion").accordion({fillSpace:"true"});

    var rootScenario = new PNI.Scenario();

});
