// vim: ai et sw=4 ts=4

var $j= jQuery.noConflict();

$j(document).ready( function () {

    // TODO per ora faccio cosi, siccome PNI::GUI::Scenario crea per prima uno scenario e quindi 
    // gli viene assegnato id 1 faccio cosi.
    var scenario = new PNI.Scenario(
    // TODO da implementare il load di uno scenario
    {
        model:{ 
            "scenarios":[],
            "edges":[{"source_id":13,"id":22,"target_id":16},{"source_id":8,"id":20,"target_id":11}],
            "nodes":[
                {"y":334,"outs":[{"type":"SCALAR","data":"CIAO","id":13}],"ins":[{"type":"SCALAR","data":"ciao","id":11}],"x":380,"type":"Perlfunc::Uc","label":"uc","id":10},
                {"y":454,"outs":[{"type":"SCALAR","data":"CIAO","id":18}],"ins":[{"type":"SCALAR","data":"CIAO","id":16}],"x":397,"type":"Perldata::Scalar","label":"$","id":15},
                {"y":153,"outs":[{"type":"SCALAR","data":"ciao","id":8}],"ins":[{"type":"SCALAR","data":"ciao","id":6}],"x":350,"type":"Perldata::Scalar","label":"$","id":5}
                ],
            "id":1
        }
    }
    );

});
