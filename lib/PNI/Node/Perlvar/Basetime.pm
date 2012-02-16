package    # Avoid PAUSE indexing.
  PNI::Node::Perlvar::Basetime;
use PNI::Node::Mo;
extends 'PNI::Node';

sub BUILD { shift->out->data($^T) }

1
