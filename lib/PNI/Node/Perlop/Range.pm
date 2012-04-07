package    # Avoid PAUSE indexing.
  PNI::Node::Perlop::Range;
use PNI::Node::Mo;
extends 'PNI::Node';

sub BUILD {
    my $self = shift;
    $self->label('..');

    $self->in(1);
    $self->in(2);
    $self->out;
}

sub task {
    my $self = shift;

    my $in1 = $self->in(1);
    my $in2 = $self->in(2);

    $in1->is_string or $in1->is_number or return;
    $in2->is_string or $in2->is_number or return;

    my @range = ( $in1->data .. $in2->data );
    $self->out->data( \@range );
}

1;

