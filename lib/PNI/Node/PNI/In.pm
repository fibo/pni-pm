package    # Avoid PAUSE indexing.
  PNI::Node::PNI::In;
use PNI::Node::Mo;
extends 'PNI::Node';

sub BUILD {
    my $self = shift;

    $self->out;
}

sub task { }

1;

