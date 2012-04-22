use strict;
use warnings;
use Test::More tests => 20;
use Test::Mojo;

my $t = Test::Mojo->new('PNI::GUI');

$t->get_ok('/')->status_is(200);

$t->get_ok('/node_list')->status_is(200);

$t->get_ok('/scenario/create')->status_is(200);

# Javascript resources.
$t->get_ok('/js/jquery-1.7.1.min.js')->status_is(200);
$t->get_ok('/js/jquery-ui-1.8.18.custom.min.js')->status_is(200);
$t->get_ok('/js/kinetic-v3.8.5.min.js')->status_is(200);
$t->get_ok('/js/Three.js')->status_is(200);
$t->get_ok('/js/require.js')->status_is(200);
$t->get_ok('/js/pni.js')->status_is(200);
$t->get_ok('/js/onload.js')->status_is(200);

