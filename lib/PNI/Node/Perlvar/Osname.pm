package PNI::Node::Perlvar::Osname;
use PNI::Node::Perlvar::Mo;
extends 'PNI::Node';

sub BUILD { shift->out->data($^O) }

1
