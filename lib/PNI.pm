package PNI;

use strict;
use warnings;

our $VERSION = '0.20';

use Exporter 'import';
use PNI::Edge;
use PNI::Finder;
use PNI::Node;
use PNI::Scenario;
use Time::HiRes;

# Smiling is better (:
# use PNI ':-D'; # exports edge, node and task
our @EXPORT_OK = qw( edge node task );
our %EXPORT_TAGS = ( '-D' => \@EXPORT_OK );

# A PNI finder.
my $find = PNI::Finder->new;

# The root scenario.
my $root = PNI::Scenario->new;

sub edge {
    my $source_node     = shift;
    my $target_node     = shift;
    my $source_out_name = shift;
    my $target_in_name  = shift;

    my $source_out = $source_node->get_out($source_out_name);
    my $target_in  = $target_node->get_in($target_in_name);

    return $root->new_edge(
        source => $source_out,
        target => $target_in
    );
}

sub files { $find->files }

sub loop {
    while (1) {
        &task;
        Time::HiRes::usleep(1);
    }
}

sub node { $root->new_node( @_ ) }

sub node_list { $find->nodes }

sub root { $root }

sub task { $root->task }

1
__END__

=head1 NAME

PNI - Perl Node Interface

=head1 ATTENTION

This module was created to be used internally by a GUI, anyway you are free to
use the scripting api if it does make sense.

=head1 INSTALLATION

To install PNI module plus a basic set of PNI nodes, do:
    
    cpan PNI::Core

=head1 SYNOPSIS

    use PNI ':-D'; # imports node, edge and task

    my $node = node 'Perlfunc::Print';
    $node->get_input('list')->set_data('Hello World !');
    $node->get_input('do_print')->set_data(1);

    task; # prints Hello World !

=head1 DESCRIPTION

Hi all! I'm an italian mathematician. 
I really like Perl philosophy as Larry jokes a lot even if 
he is one of the masters of hacking.

PNI stands for Perl Node Interface.

It is my main project, my contribution to the great Perl community. 
Node programming is really interesting since makes possible to realize a program
even if you have no idea about programming. 

Think about genetic researchers, for example. They need to focus on protein 
chains, not on what a package is. Maybe they can do an extra effort and say the
world "variable" or "string" or even "regular expression" and that makes them 
proud, but they don't care about inheritance.

They want things working and they need Perl ... 

but if you say Strawberry they think about yogurt, not about Windows.

There are a lot of node programming languages (VVVV, Puredata, Max/Msp) but
normally they target artists and interaction designers. I saw a lot of vjs and
musicians do really complex programs with those software, and they never wrote 
a line of code.

This is my effort to provide a node interface that brings Perl power 
to people who don't know the Perl language.

Blah blah blah. ( this was the h2xs command :-)

=head1 METHODS

=head2 edge

    my $source_node = PNI::node 'Some::Node';
    my $target_node = PNI::node 'Another::Node';

    my $edge = PNI::edge $source_node    => $target_node , 
               'source_output_name' => 'target_input_name';

Connects an output of a node to an input of another node.

=head2 files

    my @pni_files = PNI::files;

Returns a list of all .pni files in PNI.pm install dir and subdirs.

=head2 node

Creates a node by its PNI type, that is the name of a package under the
PNI::Node namespace, and adds it to the root scenario. If you write

    my $node = PNI::node 'Foo::Bar';

PNI loads and inits PNI::Node::Foo::Bar node. 

If no PNI type is passed, and you just write

    my $node = PNI::node;
    
PNI creates an empty node.

=head2 node_list

    my @nodes = PNI::node_list;

Returns a list of available PNI nodes.

This method delegates to L<PNI::Finder> C<nodes> method.

=head2 task

    PNI::task;

Calls the task method for every loaded node.
This method delegates to the root scenario task method.

=head2 loop

    PNI::loop;

Starts the PNI main loop. It keeps calling C<task> as fast as it can.

=head2 root

    my $root = PNI::root;

Returns the root PNI::Scenario.

=head1 SEE ALSO

L<PNI::Core>

L<PNI::GUI::Tk>

L<PNI blog|http://perl-node-interface.blogspot.com>

=head1 AUTHOR

G. Casati , E<lt>fibo@cpan.orgE<gt>

=head1 LICENSE AND COPYRIGHT

Copyright (C) 2009-2011, Gianluca Casati

This program is free software, you can redistribute it and/or modify it
under the same terms of the Artistic License version 2.0.

=cut

