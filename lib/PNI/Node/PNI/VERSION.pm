package    # Avoid PAUSE indexing.
  PNI::Node::PNI::VERSION;
use PNI::Node::Mo;
extends 'PNI::Node';

use PNI;

sub BUILD {
    my $self = shift;
    $self->label('PNI::VERSION');

    $self->out->data('0.34');
}

1;

