package    # Avoid PAUSE indexing.
  PNI::Node::List::Util::Minstr;
use PNI::Node::Mo;
extends 'PNI::Node';

use List::Util;

sub BUILD {
    my $self = shift;
    $self->label('minstr');

    $self->in;
    $self->out;
}

sub task {
    my $self = shift;

    $self->in->is_array or return $self->off;

    $self->out->data( List::Util::minstr( @{ $self->in->data } ) );
}

1;

