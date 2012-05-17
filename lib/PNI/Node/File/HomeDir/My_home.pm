package    # Avoid PAUSE indexing.
  PNI::Node::File::HomeDir::My_home;
use PNI::Node::Mo;
extends 'PNI::Node';

use File::HomeDir;

sub BUILD {
    my $self = shift;

    $self->label('Home');

    $self->out->data( File::HomeDir->my_home );
}

sub task { }

1;

