package    # Avoid PAUSE indexing.
  PNI::Node::Perlfunc::Time;
use PNI::Node::Mo;
extends 'PNI::Node';

sub BUILD {
    my $self = shift;
    $self->label('time');

    $self->in('update')->bang(0);
    $self->out->data(time);
}

sub task {
    my $self   = shift;
    my $update = $self->in('update');
    my $out    = $self->out;

    if ( $update->bang ) {
        $out->data(time);
    }
}

1;

