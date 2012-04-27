
# N.B. this file is called __use_ok.t with two underscores so it will run first.
# Find all modules under "lib" dir and check if they compile or BAIL_OUT,
# i.e. complain and end tests.

use strict;
use warnings;
use File::Find;
use Test::More;

my @modules;

find(
    {
        wanted => sub {
            my $module = $File::Find::name;
            return unless $module =~ s/\.pm$//;
            $module =~ s!^lib/!!;
            $module =~ s!/!::!g;
            push @modules, join '::', $module;
        },
        chdir => 0,
    },
    'lib'
);

use_ok($_)
  or BAIL_OUT(" $_ module does not compile :-(")
  for @modules;

done_testing;

