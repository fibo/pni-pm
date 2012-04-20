use strict;
use warnings;
use Test::More tests => 6;
use Test::Mojo;

my $t = Test::Mojo->new('PNI::GUI');

$t->get_ok('/')->status_is(200);

$t->get_ok('/node_list')->status_is(200);

$t->get_ok('/scenario/create')->status_is(200);

