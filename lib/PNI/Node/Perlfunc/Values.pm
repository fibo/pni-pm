package PNI::Node::Perlfunc::Values;
use PNI::Node::Mo;
extends 'PNI::Node';

sub BUILD {
    my $self = shift;
    $self->label('values');

    $self->in;
    $self->out;
}

sub task {
    my $self = shift;
    my $in   = $self->in;
    my $out  = $self->out;

    $in->is_hash or return $self->off;

    my @values = values( $in->data );

    $out->data( \@values );
}

1

