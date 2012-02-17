// vim: ai et sw=4 ts=4

$(document).ready( function () {

    var window = new PNI.Window();
    var outSlots = [
        {out1:"foo"},
        {out2:"bar"}
    ];

    var testNode = new PNI.Node({
        canvas:canvas,
        centerX:100,
        centerY:100,
        inSlots: [
            {in1:"foo"},
            {in2:"foo"},
            {in3:"foo"},
            {in4:"bar"}
        ],
        outSlots: []
    });
    testNode.draw();
    testNode.setOutSlots(outSlots);

});
