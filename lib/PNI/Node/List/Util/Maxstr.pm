package    # Avoid PAUSE indexing.
  PNI::Node::List::Util::Maxstr;
use PNI::Node::Mo;
extends 'PNI::Node';

use List::Util;

sub BUILD {
    my $self = shift;
    $self->label('maxstr');

    $self->in;
    $self->out;
}

sub task {
    my $self = shift;

    $self->is_array or return $self->off;

    $self->out->data( List::Util::maxstr( $self->in->data ) );
}

1;

