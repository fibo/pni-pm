package    # Avoid PAUSE indexing.
  PNI::Node::Perlvar::Osname;
use PNI::Node::Mo;
extends 'PNI::Node';

sub BUILD { shift->out->data($^O) }

1
