package PNI::In;
use PNI::Mo;
extends 'PNI::Slot';

use PNI::Edge;
use PNI::Elem;

has edge => ();

sub by_id {
    my $elem = PNI::Elem::by_id(@_);

    if ( defined $elem and $elem->isa('PNI::In') ) {
        return $elem;
    }
    else {
        return;
    }
}

sub is_connected { return defined( shift->edge ) ? 1 : 0 }

1;

__END__

=head1 NAME

PNI::In - is a node input

=head1 SYNOPSIS

    my $node = PNI::Node->new;
    my $in = PNI::In->new( 
        id => 'in',
        node => $node, 
    );

=head1 ATTRIBUTES

=head2 edge

    my $edge = $in->edge;

Return the input slot's edge. Remember that a L<PNI::In> can 
hold only one edge.

=head1 METHODS

=head2 by_id

    use PNI::In;

    my $in = PNI::In::by_id($in_id);

Given a slot id, returns a reference to the slot.

=head2 is_connected

    $in->is_connected;

=cut

