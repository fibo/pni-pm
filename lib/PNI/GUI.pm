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

=head1 DESCRIPTION

It is a webapp implemented with L<Mojolicious> that let you use the Perl Node Interface.
Talking with MVC terms, code outside the PNI::GUI namespace builds the Model.
Perl code inside PNI::GUI belongs to the Controller, everything else (HTML/CSS/JavaScript) is part of the View. 

=cut

