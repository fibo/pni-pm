package PNI::GUI;
use Mojo::Base 'Mojolicious';

use File::Basename 'dirname';
use File::Spec::Functions 'catdir';

use PNI::Finder;
my $find = PNI::Finder->new;

sub startup {
    my $self = shift;

    $self->home->parse( catdir( dirname(__FILE__), 'GUI' ) );
    $self->static->paths->[0]   = $self->home->rel_dir('public');
    $self->renderer->paths->[0] = $self->home->rel_dir('templates');

    # Add PNI node path as a static dir.
    $self->static->paths->[1] = catdir( dirname(__FILE__), 'Node' );

    my $r = $self->routes;
    $r->get('/')->to( cb => sub { shift->render('MainWindow') } );
    $r->get('/node_list')->to(
        cb => sub {
            my @node_list = $find->nodes;
            shift->render_json( \@node_list );
        }
    );

    $r->get('/edge/:edge_id')->to('edge#to_json');
    $r->post('/edge')->to('scenario#add_edge');

    $r->get('/node/:node_id')->to('node#to_json');
    $r->post('/node')->to('scenario#add_node');
    $r->post('/node/:node_id')->to('node#update_position');
    $r->delete('/node/:node_id')->to('scenario#del_node');

    $r->get('/scenario/:scenario_id')->to('scenario#to_json');
    $r->get('/scenario/:scenario_id/task')->to('scenario#run_task');

    $r->get('/slot/:slot_id/data')->to('slot#get_data');
    $r->post('/slot/:slot_id/data')->to('slot#set_data');

}

1;

__END__

=head1 NAME

PNI::GUI - is a cool webapp

=head1 DESCRIPTION

It is a webapp implemented with L<Mojolicious> that let you use the Perl Node Interface.
Talking with MVC terms, code outside the PNI::GUI namespace builds the Model.
Perl code inside PNI::GUI belongs to the Controller, everything else (HTML/CSS/JavaScript) is part of the View. 

=head1 ROUTES

=head2 DEL /edge/:edge_id

=head2 GET /edge/:edge_id

=head2 PUT /edge

=head2 DEL /node/:node_id

=head2 GET /node/:node_id

=head2 PUT /node

=head2 DEL /scenario/:scenario_id

=head2 GET /scenario/:scenario_id

=head2 PUT /scenario

=cut

