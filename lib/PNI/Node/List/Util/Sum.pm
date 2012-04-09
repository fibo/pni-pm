package    # Avoid PAUSE indexing.
  PNI::Node::List::Util::Sum;
use PNI::Node::Mo;
extends 'PNI::Node';

use List::Util;

sub BUILD {
    my $self = shift;
    $self->label('sum');

    $self->in;
    $self->out;
}

sub task {
    my $self = shift;

    $self->in->is_array or return $self->off;

    $self->out->data( List::Util::sum( 0, @{ $self->in->data } ) );
}

1;

