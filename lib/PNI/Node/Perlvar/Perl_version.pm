package    # Avoid PAUSE indexing.
  PNI::Node::Perlvar::Perl_version;
use PNI::Node::Mo;
extends 'PNI::Node';

sub BUILD { shift->out->data($^V) }

1
