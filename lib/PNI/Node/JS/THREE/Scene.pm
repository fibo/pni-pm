package    # Avoid PAUSE indexing.
  PNI::Node::JS::THREE::Scene;
use PNI::Node::Mo;

extends 'PNI::Node';

sub BUILD {
    my $self = shift;

    $self->label('svarionz');
}

sub task { }

1;

