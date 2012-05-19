package    # Avoid PAUSE indexing.
  PNI::Node::PNI::Comment;
use PNI::Node::Mo;
extends 'PNI::Node';

sub BUILD { shift->label('#'); }

sub task { }

1;

