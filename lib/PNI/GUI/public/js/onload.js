// vim: ai et sw=4 ts=4

var $j= jQuery.noConflict();

$j(document).ready( function () {

    // TODO per ora faccio cosi, siccome PNI::GUI::Scenario crea per prima uno scenario e quindi 
    // gli viene assegnato id 1 faccio cosi.
    var scenario = new PNI.Scenario(
    {model:{ id:1 }}
    );

});
