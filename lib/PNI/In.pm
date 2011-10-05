package PNI::In;
use PNI::Mo;
extends 'PNI::Slot';
use PNI::Edge;

has edge => ( defualt => sub { } );

sub is_connected { defined( shift->edge ) ? 1 : 0 }

1
__END__

=head1 NAME

PNI::In - node input

=head1 ATTRIBUTES

=head2 edge

=head1 METHODS

=head2 is_connected

    $in->is_connected;

=cut

