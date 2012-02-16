package    # Avoid PAUSE indexing.
  PNI::Node::PNI::Root;
use PNI::Mo;
extends 'PNI::Node';

use PNI;

sub BUILD {
    shift->out('object')->data( PNI::root() );
}

1
