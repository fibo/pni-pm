package    # Avoid PAUSE indexing.
  PNI::GUI::Node;
use Mojo::Base 'Mojolicious::Controller';

use PNI::Node;

sub update_position {
    my $self = shift;
    my $log  = $self->app->log;

    my $x = $self->param('x');
    my $y = $self->param('y');

    my $node_id = $self->stash('node_id');

    my $node = PNI::Node::by_id($node_id);

    $log->debug("node $node_id ( $x, $y )");

    $node->x($x);
    $node->y($y);

    $self->render_json( {}, status => 200 );
}

sub to_json {
    my $self = shift;
    my $log  = $self->app->log;

    my $node_id = $self->stash('node_id');

    my $node = PNI::Node::by_id($node_id);

    $self->render_json( $node->to_hashref );
}

1;

