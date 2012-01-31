package PNI::Elem;
use PNI::Mo;
use Scalar::Util;

has id => ( default => sub { Scalar::Util::refaddr(shift) } );

1
__END__

=head1 NAME

PNI::Elem - is a base class

=head1 ATTRIBUTES

=head2 id

=head1 METHODS

=cut

