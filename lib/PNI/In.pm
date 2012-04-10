package PNI::In;
use PNI::Mo;
extends 'PNI::Slot';

use PNI::Edge;

has edge => ();

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

=head2 is_connected

    $in->is_connected;

=cut

