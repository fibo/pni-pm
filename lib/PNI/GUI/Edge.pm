package    # Avoid PAUSE indexing.
  PNI::GUI::Edge;
use Mojo::Base 'Mojolicious::Controller';

use PNI::Elem;

sub to_json {
    my $self = shift;

    my $edge_id = $self->stash('edge_id');

    my $edge = PNI::Elem::by_id($edge_id);

    $self->render_json( $edge->to_hashref );
}

1;


