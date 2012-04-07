package    # Avoid PAUSE indexing.
  PNI::Node::PNI::Comment;
use PNI::Node::Mo;
extends 'PNI::Node';

sub BUILD {
    my $self = shift;
    $self->in('content');
}

1;

