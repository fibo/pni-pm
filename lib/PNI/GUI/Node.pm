package    # Avoid PAUSE indexing.
  PNI::GUI::Node;
use Mojo::Base 'Mojolicious::Controller';

use PNI::Node;

sub to_json {
    my $self = shift;

    my $node_id = $self->stash('node_id');

    my $node = PNI::Node::by_id($node_id);

    $self->render_json( $node->to_hashref );
}

1;

