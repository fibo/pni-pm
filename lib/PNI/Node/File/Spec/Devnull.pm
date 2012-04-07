package    # Avoid PAUSE indexing.
  PNI::Node::File::Spec::Devnull;
use PNI::Node::Mo;
extends 'PNI::Node';

use File::Spec;

sub BUILD {
    my $self = shift;
    $self->label('devnull');

    my $out     = $self->out;
    my $devnull = File::Spec->devnull;
    $out->data($devnull);
}

1;

