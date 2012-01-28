package PNI::Node::Perlfunc::Keys;
use PNI::Node::Mo;
extends 'PNI::Node';

sub BUILD {
    my $self = shift;
    $self->label('keys');

    $self->in;
    $self->out;
}

sub task {
    my $self = shift;
    my $in   = $self->in;
    my $out  = $self->out;

    $in->is_hash or return $self->off;

    my @keys = keys( $in->data );

    $out->data( \@keys );
}

1

