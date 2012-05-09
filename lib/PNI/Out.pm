package PNI::Out;
use PNI::Mo;
extends 'PNI::Slot';

use PNI::Elem;
use PNI::Set;

has edges => ( default => sub { return PNI::Set->new; } );

sub by_id {
    my $elem = PNI::Elem::by_id(@_);

    if ( defined $elem and $elem->isa('PNI::Out') ) {
        return $elem;
    }
    else {
        return;
    }
}

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

=head2 by_id

    use PNI::Out;

    my $out = PNI::Out::by_id($out_id);

Given a slot id, returns a reference to the slot.

=head2 is_connected

    $out->is_connected;

=cut

