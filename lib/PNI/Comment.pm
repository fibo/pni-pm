package PNI::Comment;
use Mo;
extends 'PNI::Elem';

has box     => ( default => sub { PNI::Rectangle->new } );
has content => ( default => sub { '' } );

1
__END__

=head1 NAME

PNI::Comment

=head1 ATTRIBUTES

=head2 box

=head2 content

=cut

