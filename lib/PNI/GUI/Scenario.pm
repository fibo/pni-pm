package    # Avoid PAUSE indexing.
  PNI::GUI::Scenario;
use Mojo::Base 'Mojolicious::Controller';

use PNI::Scenario;
my $scenario = PNI::Scenario->new;

sub add_edge {
    my $self = shift;
    my $log  = $self->app->log;

    my $source_node_id = $self->req->param('source_node_id');
    my $source_slot_id = $self->req->param('source_slot_id');
    my $target_node_id = $self->req->param('target_node_id');
    my $target_slot_id = $self->req->param('target_slot_id');

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
    my $log  = $self->app->log;

    my $type = $self->req->param('type');
    my $x    = $self->req->param('x');
    my $y    = $self->req->param('y');

    $log->debug("add_node ($type)");
    my $node = $scenario->add_node( $type, x => $x, y => $y );

    $self->render_json( $node->to_hashref, status => 201 );
}

sub to_json {
    my $self = shift;

    $self->render_json( $scenario->to_hashref );
}

1;

