use strict;
use warnings;
use Test::More tests => 2;
use Test::Mojo;

my $t = Test::Mojo->new('PNI::GUI');

$t->get_ok('/')->status_is(200);

