package PNI::Rectangle;
use PNI::Mo;
use PNI::Point;

has center => ( default => sub { PNI::Point->new } );
has height => ( default => sub { 0 } );
has width  => ( default => sub { 0 } );

sub translate { shift->center->translate(@_) }

1
__END__

=head1 NAME

PNI::Rectangle

=head1 ATTRIBUTES

=head2 center

=head2 height

=head2 width

=head1 METHODS 

=head2 translate

=cut

