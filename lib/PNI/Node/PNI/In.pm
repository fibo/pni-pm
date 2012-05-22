package    # Avoid PAUSE indexing.
  PNI::Node::PNI::In;
use PNI::Node::Mo;
extends 'PNI::Node';

sub BUILD { shift->label('in'); }

sub task { }

1;

