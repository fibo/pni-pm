package    # Avoid PAUSE indexing.
  PNI::Node::Perlfunc::Time;
use PNI::Node::Mo;
extends 'PNI::Node';

sub BUILD {
    my $self = shift;
    $self->label('time');

    $self->in('update'); # TODO deve essere un bang
    $self->out; # TODO deve essere un single
}

sub task {
    my $self = shift;
    my $update   = $self->in('update');
    my $out  = $self->out;

    $in->is_number or return $self->off;

    $out->data( time );
}

1;


