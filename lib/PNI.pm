package PNI;

use strict;
use warnings;

# As recommended in permodstyle's "Version numbering" section
# considering version x.yy stable, a new release will be versioned
# as x.yy_zz so it will not be listed by CPAN.pm as the last.
# After test results will be ok, it can be officially released x.(yy+1) version.
our $VERSION = '0.32';
$VERSION = eval $VERSION;

1;

__END__

=head1 NAME

PNI - stands for Perl Node Interface

=head1 SYNOPSIS

    $ pni daemon

Then point your browser to http://localhost:3000 and use the gui.

=head1 DESCRIPTION

Hi all! I'm an italian mathematician.  I really like Perl philosophy as Larry jokes a lot even if he is one of the masters of hacking.

PNI stands for Perl Node Interface.

It is my main project, my contribution to the great Perl community. Node programming is really interesting since makes possible to realize a program even if you have no idea about programming. 

Think about genetic researchers, for example. They need to focus on protein chains, not on what a package is. Maybe they can do an extra effort and say the world "variable" or "string" or even "regular expression" and that makes them proud, but they don't care about inheritance.

They want things working and they need Perl ... but if you say L<Strawberry|http://strawberryperl.com/> they think about yogurt, not about Windows.

There are a lot of node programming languages (L<VVVV|http://vvvv.org/>, L<Puredata|http://puredata.info/>, L<Max/Msp|http://cycling74.com/>) but normally they target artists and interaction designers. I saw a lot of vjs and musicians do really complex programs with those software, and they never wrote a line of code.

This is my effort to provide a node interface that brings Perl power to people who don't know the Perl language.

Blah blah blah. ( this was the h2xs command :-)

=head1 SEE ALSO

L<PNI::Guides>

L<PNI::Edge>

L<PNI::Node>

L<PNI::Scenario>

L<PNI demo|http://pnidemo-fibo.dotcloud.com>

=head1 RESOURCES

L<PNI blog|http://perl-node-interface.blogspot.com>

L<PNI repository|http://github.com/fibo/pni-pm>

L<PNI class diagram|http://goo.gl/MQ89f>

L<PNI node coverage|http://goo.gl/hfAoU>

=head1 AUTHOR

G. Casati , E<lt>fibo@cpan.orgE<gt>

=head1 LICENSE AND COPYRIGHT

Copyright (C) 2009-2012, Gianluca Casati

This program is free software, you can redistribute it and/or modify it
under the same terms of the Artistic License version 2.0.

=cut

