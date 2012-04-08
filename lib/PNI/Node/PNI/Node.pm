package    # Avoid PAUSE indexing.
  PNI::Node::PNI::Node;
use PNI::Node::Mo;
extends 'PNI::Node';

sub BUILD {
    my $self = shift;

    $self->label('node');
}

sub task {
    my $self = shift;

}

1;

