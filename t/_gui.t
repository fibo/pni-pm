use strict;
use warnings;
use Test::More tests => 17;
use Test::Mojo;

use PNI::Finder;

# Use some test nodes, under t/PNI/Node path.
use lib 't';

my $t = Test::Mojo->new('PNI::GUI');

$t->get_ok('/')

  # Status is ok.
  ->status_is(200)

  # Check content type.
  ->content_type_is('text/html;charset=UTF-8')

  # Check title.
  #->text_is( 'html head title' => 'Perl Node Interface', 'title' )

  # End of Main Window tests.
  ;

# Javascript resources.
$t->get_ok('/js/jquery-1.7.1.min.js')->status_is(200);
$t->get_ok('/js/jquery-ui-1.8.18.custom.min.js')->status_is(200);
$t->get_ok('/js/kinetic-v3.8.5.min.js')->status_is(200);
$t->get_ok('/js/Three.js')->status_is(200);
$t->get_ok('/js/require.js')->status_is(200);
$t->get_ok('/js/pni.js')->status_is(200);
$t->get_ok('/js/onload.js')->status_is(200);

__END__

my $find      = PNI::Finder->new;
my @node_list = $find->nodes;
$t->get_ok('/node_list')->status_is(200)->json_is( \@node_list );


$t->put_ok('/scenario')->status_is(201)->json_has('id');
my $scenario_id = 'boh';

my $node_type = 'Twice';

$t->put_ok( '/node',
    { scenario_id => $scenario_id, type => $node_type, x => 10, y => 10 } )
  ->status_is(201)->json_is( { TODO => 'FILLME' } );

$t->put_ok( '/node',
    { scenario_id => $scenario_id, type => $node_type, x => 40, y => 50 } )
  ->status_is(201)->json_is( { TODO => 'FILLME' } );

$t->put_ok( '/edge',
    { scenario_id => $scenario_id, source_id => 1, target_id => 2 } )
  ->status_is(201)->json_is( { TODO => 'FILLME' } );

my $scenario = undef;
$t->get_ok("scenario/$scenario_id")->status_is(200)
  ->json_is( $scenario->to_hash_ref );

