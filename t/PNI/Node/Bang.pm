package PNI::Node::Bang;
use PNI::Mo;
extends 'PNI::Node';

sub BUILD {
    my $self = shift;

    $self->in->bang(0);
}

sub task { return 1; }

1;

