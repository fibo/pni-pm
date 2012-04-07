package    # Avoid PAUSE indexing.
  PNI::Node::Perlfunc::Keys;
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
    my $hash_ref = $in->data;
    my @keys     = keys( %{$hash_ref} );

    $out->data( \@keys );
}

1;

