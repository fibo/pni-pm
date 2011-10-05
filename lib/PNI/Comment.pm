package PNI::Comment;
use PNI::Mo;
extends 'PNI::Elem';

has box     => ( default => sub { PNI::Rectangle->new } );
has content => ( default => sub { '' } );

sub translate { shift->box->translate(@_) }

1
__END__

=head1 NAME

PNI::Comment

=head1 ATTRIBUTES

=head2 box

=head2 content

=head1 METHODS

=head1 translate

=cut

