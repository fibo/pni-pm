package PNI::GUI;
use Mojo::Base 'Mojolicious';

use File::Basename 'dirname';
use File::Spec;

sub startup {
    my $self = shift;
    my $r    = $self->routes;

    # TODO: $self->secret( $ENV{PNIGUI_SECRET} ); and document env var as well as MOJO_MODE

    $self->home->parse( File::Spec->catdir( dirname(__FILE__), 'GUI' ) );
    $self->static->root( $self->home->rel_dir('public') );
    $self->renderer->root( $self->home->rel_dir('templates') );

}

1
__END__

=head1 NAME

PNI::GUI - is a cool webapp

=cut

