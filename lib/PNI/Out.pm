package PNI::Out;
use PNI::Mo;
extends 'PNI::Slot';
use PNI::Set;

has edges => ( default => sub { PNI::Set->new } );

sub is_connected { return shift->edges->list ? 1 : 0 }

1;

__END__

=head1 NAME

PNI::Out - is a node output

=head1 SYNOPSIS

    my $node = PNI::Node->new;
    my $out = PNI::Out->new( 
        id => 'out',
        node => $node, 
    );

=head1 ATTRIBUTES

=head2 edges

    my $edge = PNI::Edge->new;

    $out->edges->add($edge);

    $out->edges->del($another_edge);

    my @edges = $out->edges->list;

=head1 METHODS

=head2 is_connected

    $out->is_connected;

=cut

