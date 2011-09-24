package PNI::Slot;
use Mo;
extends 'PNI::Elem';

has box  => ( default => sub { PNI::Rectangle->new } );
has data => ( default => sub { undef } );

1
__END__

=head1 NAME

PNI::Slot - is a basic unit of data

=head1 ATTRIBUTES

=head2 data

=head2 box

=cut

