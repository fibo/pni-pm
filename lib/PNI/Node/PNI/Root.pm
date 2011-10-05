package PNI::Node::PNI::Root;
use PNI::Mo;
extends 'PNI::Node';
use PNI;

sub BUILD {
    my $node = shift;

    $node->new_out( 'object', data => PNI::root() );
}

1
__END__

