package    # Avoid PAUSE indexing.
  PNI::GUI::Scenario;
use Mojo::Base 'Mojolicious::Controller';

use Mojo::Log;
use PNI::Scenario;
use PNI::Set;

my $log   = Mojo::Log->new;
my $model = PNI::Set->new;
my $root  = PNI::Scenario->new( id => 'root' );

$model->add($root);

sub add_edge {
    my $self = shift;

    my $scenario_id    = $self->req->param('scenario_id');
    my $source_node_id = $self->req->param('source_node_id');
    my $source_slot_id = $self->req->param('source_slot_id');
    my $target_node_id = $self->req->param('target_node_id');
    my $target_slot_id = $self->req->param('target_slot_id');

    my $scenario = $model->elem->{$scenario_id};

    my $source_node = $scenario->nodes->elem->{$source_node_id};
    my $target_node = $scenario->nodes->elem->{$target_node_id};

    my $source = $source_node->out($source_slot_id);
    my $target = $target_node->in($target_slot_id);

    $log->debug("add_edge ($source_slot_id => $target_slot_id");
    my $edge = $scenario->add_edge( source => $source, target => $target );

    $self->render_json( $edge->to_hashref, status => 201 );
}

sub add_node {
    my $self = shift;

    my $scenario_id = $self->req->param('scenario_id');
    my $type        = $self->req->param('type');
    my $x           = $self->req->param('x');
    my $y           = $self->req->param('y');

    my $scenario = $model->elem->{$scenario_id};

    $log->debug("add_node ($type)");
    my $node = $scenario->add_node( $type, x => $x, y => $y );

    $self->render_json( $node->to_hashref, status => 201 );
}

sub to_json {
    my $self = shift;

    my $scenario_id = $self->stash('scenario_id');
    my $scenario    = $model->elem->{$scenario_id};

    if ( defined $scenario ) {
        $self->render_json( $scenario->to_hashref );
    }
    else {
        $self->render_json( {}, status => 404 );
    }
}

1;

