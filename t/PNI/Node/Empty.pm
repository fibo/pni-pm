package PNI::Node::Empty;
use PNI::Mo;
extends 'PNI::Node';

sub BUILD {
    my $self = shift;
    $self->in;
    $self->out;
}

sub task { return 1; }

1;

