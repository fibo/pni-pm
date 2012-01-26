package PNI::Node::Perlvar::Basetime;
use PNI::Node::Perlvar::Mo;
extends 'PNI::Node';

sub BUILD { shift->out->data($^T) }

1
