package    # Avoid PAUSE indexing.
  PNI::Node::Perlvar::Basetime;
use PNI::Node::Mo;
extends 'PNI::Node';

sub BUILD {
    my $self = shift;
    $self->label('$BASETIME');
    $self->out->data($^T);
}

1;
