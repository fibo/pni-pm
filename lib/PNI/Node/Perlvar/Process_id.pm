package PNI::Node::Perlvar::Process_id;
use PNI::Node::Perlvar::Mo;
extends 'PNI::Node';

sub BUILD { shift->out->data($$) }

1
