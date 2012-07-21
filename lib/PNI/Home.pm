package PNI::Home;
use PNI::Mo;

use File::HomeDir;
use Path::Class;

has path => (
    is      => 'ro',
    default => sub {
        my $path = dir( File::HomeDir->my_home )->subdir('.pni');
        return $path;
    }
);

1;

__END__

=head1 NAME

PNI::Home - ditto

=head1 SYNOPSIS

    my $home = PNI::Home->new;

=head1 ATTRIBUTES

=head2 path

    my $path = $home->path;

Returns the path of PNI's home directory, that is $HOME/.pni by default.

=head1 METHODS

L<PNI::Home> has no method.

=cut

