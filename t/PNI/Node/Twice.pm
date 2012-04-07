package PNI::Node::Twice;
use PNI::Mo;
extends 'PNI::Node';

sub BUILD {
    my $self = shift;
    $self->in->data(0);
    $self->out->data(0);
}

sub task {
    my $self = shift;
    $self->out->data( $self->in->data * 2 );
}

1;

