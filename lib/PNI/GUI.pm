package PNI::GUI;
use Mojo::Base 'Mojolicious';

use File::Basename 'dirname';
use File::Spec::Functions 'catdir';

sub startup {
    my $self = shift;

# TODO: $self->secret( $ENV{PNIGUI_SECRET} ); and document env var as well as MOJO_MODE

    $self->home->parse( catdir( dirname(__FILE__), 'GUI' ) );
    $self->static->paths->[0]   = $self->home->rel_dir('public');
    $self->renderer->paths->[0] = $self->home->rel_dir('templates');

    my $r = $self->routes;
    $r->get('/')->to( cb => sub { shift->render('MainWindow') } );
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

