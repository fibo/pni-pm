package PNI::Slot;
use PNI::Mo;
extends 'PNI::Elem';

has box  => ( default => sub { PNI::Rectangle->new } );
has data => ( default => sub { } );
has node => ( default => sub { } );

sub translate { shift->box->translate(@_) }

1
__END__

=head1 NAME

PNI::Slot - is a basic unit of data

=head1 ATTRIBUTES

=head2 box

=head2 data

=head2 node

=head1 METHODS

=head2 translate

=cut

