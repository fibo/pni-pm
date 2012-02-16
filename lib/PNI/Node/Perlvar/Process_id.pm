package    # Avoid PAUSE indexing.
  PNI::Node::Perlvar::Process_id;
use PNI::Node::Mo;
extends 'PNI::Node';

sub BUILD { shift->out->data($$) }

1
