package PNI::Node::Twice;
use PNI::Mo;
extends 'PNI::Node';

sub BUILD {
    my $self = shift;
    my $in   = $self->new_in('in')->data(0);
    $self->new_out('out')->data(0);
}

sub task {
    my $self = shift;
    $self->get_out('out')->data( $self->get_in('in')->data * 2 );
}

1;
