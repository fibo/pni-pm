package PNI;

use strict;
use warnings;

# As recommended in permodstyle's "Version numbering" section
# considering version x.yy stable, a new release will be versioned
# as x.yy_zz so it will not be listed by CPAN.pm as the last.
# After test results will be ok, it can be officially released x.(yy+1) version.

our $VERSION = '0.34';
$VERSION = eval $VERSION;

1;

__END__

=head1 NAME

PNI - stands for Perl Node Interface

=head1 SYNOPSIS

    $ pni daemon

Then point your browser to http://localhost:3000 and use the gui.

=head1 DESCRIPTION

Perl Node Interface is a node programming IDE via browser. 
It is thinked to give Perl power to people who don-t know Perl.
It is very easy for Perl coders to extend it adding new nodes.

=head1 SEE ALSO

L<PNI::Guides>

L<PNI demo|http://pnidemo-fibo.dotcloud.com>

=head1 DEVELOPMENT

L<PNI repository|http://github.com/fibo/pni-pm>

=head1 RESOURCES

L<PNI blog|http://perl-node-interface.blogspot.com>

L<PNI class diagram|http://goo.gl/MQ89f>

L<PNI node coverage|http://goo.gl/hfAoU>

=head1 SUPPORT

L<#pni IRC channel on freenode|irc://freenode/pni>

L<PNI mailing list|http://groups.google.com/group/perl-node-interface>

=head1 AUTHOR

G. Casati , E<lt>fibo@cpan.orgE<gt>

=head1 LICENSE AND COPYRIGHT

Copyright (C) 2009-2012, Gianluca Casati

This program is free software, you can redistribute it and/or modify it
under the same terms of the Artistic License version 2.0.

=cut

