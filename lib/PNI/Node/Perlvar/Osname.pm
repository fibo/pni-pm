package    # Avoid PAUSE indexing.
  PNI::Node::Perlvar::Osname;
use PNI::Node::Mo;
extends 'PNI::Node';

sub BUILD {
    my $self = shift;
    $self->label('$OSNAME');
    $self->out->data($^O);
}

1;
