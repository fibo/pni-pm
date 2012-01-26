package PNI::Node::Perlvar::Perl_version;
use PNI::Node::Perlvar::Mo;
extends 'PNI::Node';

sub BUILD { shift->out->data($^V) }

1
