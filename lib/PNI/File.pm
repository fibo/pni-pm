package PNI::File;
use PNI::Mo;

use File::Spec;
use File::Temp;
use JSON::PP;

my $suffix = '.pni';

has content => ( default => sub { { edges => {}, nodes => {} } } );

has path => (
    default => sub {
        my $self = shift;

        # Create a temporary file,
        my ( $fh, $path ) = File::Temp::tempfile( SUFFIX => $suffix );
        close $fh;

        return $path;
    }
);

# TODO change this sub name: read is a builtin
sub read {
    my $self = shift;

    local $/;
    open my $fh, '<', $self->path;
    my $text = <$fh>;
    $self->content( decode_json($text) );
    close $fh;

    # TODO should return something more useful
    return 1;
}

sub write {
    my $self = shift;

    open my $fh, '>', $self->path;
    print $fh encode_json( $self->content );
    close $fh;

    # TODO should return something more useful
    return 1;
}

1;

__END__

=head1 NAME

PNI::File - stores a scenario in a .pni file

=head1 SYNOPSIS

    use PNI::File;

    my $file = PNI::File->new( path => '/path/to/my/file.pni' );

=head1 ATTRIBUTES

=head2 content

=head2 path

=head1 METHODS

=head2 read

=head2 write

=cut

