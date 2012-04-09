package    # Avoid PAUSE indexing.
  PNI::Node::PNI::Root;
use PNI::Node::Mo;
extends 'PNI::Node';

use PNI;

my $root = PNI::root();

sub BUILD {
    my $self = shift;

    $self->out('object')->data($root);
    $self->out('scenarios');
}

sub task {
    my $self = shift;

    $self->out('scenarios')->data( $root->scenarios->list );
}

1;

