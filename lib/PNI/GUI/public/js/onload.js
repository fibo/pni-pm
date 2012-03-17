// vim: ai et sw=4 ts=4

var $j= jQuery.noConflict();

$j(document).ready( function () {

    $j("#tabs").tabs({event:"mouseover"});

    $j.getJSON(
        'node_list',
        function(nodeList) { 
            $j("#node-list").autocomplete({source:nodeList}); 
        }
    );
    //var rootScenario = new PNI.Scenario({$parentContainer:$container});

});
